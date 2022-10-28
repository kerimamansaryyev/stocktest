import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:manager_provider/manager_provider.dart';
import 'package:stocktest/src/localization/extensions.dart';
import 'package:stocktest/src/services/company_details/manager.dart';
import 'package:stocktest/src/services/company_details/tasks.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';
import 'package:stocktest/src/utils/string_extensions.dart';
import 'package:stocktest/src/utils/theme/theme.dart';
import 'package:stocktest/src/utils/theme/typography.dart';
import 'package:stocktest/src/widget_components/error_widget.dart';
import 'package:stocktest/src/widget_components/full_screen_wrapper.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final String symbol;

  const CompanyDetailsScreen({
    required this.symbol,
    super.key,
  });

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  final CompanyDetailsManager _detailsManager = CompanyDetailsManager();
  bool _firstBuild = true;

  @override
  void didChangeDependencies() {
    _getDetailsInitially();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _detailsManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ManagerProvider<CompanyDetailsManager>.value(
      value: _detailsManager,
      builder: (context, __) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(context.translation.companyDetailsTitle),
          ),
          child: TaskEventListener<CompanyDetailsManager>(
            taskId: CompanyDetailsGetDataTask.taskId,
            shouldUpdate: (prev, next) => prev != next,
            builder: (context, event, __) {
              final status = event.status;
              final details = _detailsManager.state.detailsDTO;
              final isError = status == TaskProgressStatus.none ||
                  status == TaskProgressStatus.error;
              final isLoading = status == TaskProgressStatus.loading;
              final isSuccess = !isError && !isLoading && details != null;
              final dataRows = {...?details?.dataRows(context)};

              return Padding(
                padding: EdgeInsets.only(
                  top: AppThemes.navbarHeight(context),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      slivers: [
                        if (isSuccess)
                          CupertinoSliverRefreshControl(
                            onRefresh: () async => _refresh(),
                          ),
                        if (isError)
                          SliverToBoxAdapter(
                            child: AppFullScreenWrapper(
                              minHeight: constraints.maxHeight,
                              child: Padding(
                                padding: AppThemes.bodyContentPadding(context),
                                child: _errorWidgetBuilder(
                                  event: event,
                                ),
                              ),
                            ),
                          )
                        else if (isLoading)
                          SliverToBoxAdapter(
                            child: AppFullScreenWrapper(
                              minHeight: constraints.maxHeight,
                              child: const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                          )
                        else if (isSuccess)
                          SliverPadding(
                            padding: AppThemes.bodyContentPadding(context)
                                .copyWith()
                                .copyWith(
                                  top: 25.adaptedPx(context),
                                ),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate.fixed(
                                [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            details.name,
                                            style: AppTypographies.h1
                                                .style(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35.adaptedPx(context),
                                  ),
                                  for (var key in dataRows.keys)
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 30.adaptedPx(context),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            '$key: ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.adaptedPx(context),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                dataRows[key]!.capitalize(),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _getDetails() {
    _detailsManager.getDetails(widget.symbol);
  }

  void _getDetailsInitially() {
    if (_firstBuild) {
      _getDetails();
      _firstBuild = false;
    }
  }

  void _refresh() => _getDetails();

  Widget _errorWidgetBuilder({
    required TaskEvent? event,
  }) {
    String? message;
    if (event is TaskErrorEvent && event.exception is GenericMessageException) {
      message = (event.exception as GenericMessageException).message;
    }

    return AppErrorWidget(
      label: message,
      tryAgain: _refresh,
    );
  }
}
