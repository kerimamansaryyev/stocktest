import 'package:adaptix/adaptix.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:manager_provider/manager_provider.dart';
import 'package:stocktest/src/localization/extensions.dart';
import 'package:stocktest/src/services/home/manager.dart';
import 'package:stocktest/src/services/home/tasks.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';
import 'package:stocktest/src/utils/theme/theme.dart';
import 'package:stocktest/src/utils/theme/typography.dart';
import 'package:stocktest/src/widget_components/error_widget.dart';
import 'package:stocktest/src/widget_components/full_screen_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeManager _homeManager = HomeManager();
  bool _firstBuild = true;

  @override
  void didChangeDependencies() {
    _getInitialOverviews();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _homeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ManagerProvider<HomeManager>.value(
      value: _homeManager,
      builder: (context, __) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(context.translation.homeTitle),
          ),
          child: TaskEventListener<HomeManager>(
            taskId: HomeGetOverviewsTask.taskId,
            shouldUpdate: (prev, next) => prev != next,
            builder: (context, event, __) {
              final status = event.status;
              final isError = status == TaskProgressStatus.none ||
                  status == TaskProgressStatus.error;
              final isLoading = status == TaskProgressStatus.loading;
              final isSuccess = !isError && !isLoading;
              final homeState = _homeManager.state;

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
                                  Center(
                                    child: Text(
                                      context.translation
                                          .marketCapitalizationChart,
                                      style: AppTypographies.h2.style(context),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.adaptedPx(context),
                                  ),
                                  SizedBox(
                                    height: 150.adaptedPx(context),
                                    child: PieChart(
                                      PieChartData(
                                        sections:
                                            _convertCompanyOverviewsToSections(
                                          context: context,
                                          state: homeState,
                                          textStyle: TextStyle(
                                            fontSize: 12.adaptedPx(context),
                                            fontWeight: FontWeight.w500,
                                            color: CupertinoColors.black,
                                          ),
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.adaptedPx(context),
                                  ),
                                  _buildDescriptions(
                                    context: context,
                                    state: homeState,
                                  )
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

  void _getOverviews() {
    _homeManager.getCompanyOverviews();
  }

  void _getInitialOverviews() {
    if (_firstBuild) {
      _getOverviews();
      _firstBuild = false;
    }
  }

  void _refresh() => _getOverviews();

  List<PieChartSectionData> _convertCompanyOverviewsToSections({
    required BuildContext context,
    required HomeManagerState state,
    required TextStyle textStyle,
  }) =>
      state.companyOverviews
          .map<PieChartSectionData>(
            (element) => PieChartSectionData(
              color: element.color,
              title: state.percentLabelOf(element.marketCapitalization),
              value: element.marketCapitalization,
              titleStyle: textStyle,
              radius: 70.adaptedPx(context),
              titlePositionPercentageOffset: 0.6,
            ),
          )
          .toList();

  Widget _buildDescriptions({
    required BuildContext context,
    required HomeManagerState state,
  }) {
    return Column(
      children: [
        for (var overview in state.companyOverviews)
          Container(
            margin: EdgeInsets.only(
              bottom: 10.adaptedPx(context),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: overview.color,
                    borderRadius: BorderRadius.circular(
                      3.adaptedPx(context),
                    ),
                  ),
                  height: 20.adaptedPx(context),
                  width: 30.adaptedPx(context),
                ),
                SizedBox(
                  width: 5.adaptedPx(context),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    '- ${overview.name} (${overview.marketCapitalizationLabel})',
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
      ],
    );
  }

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
