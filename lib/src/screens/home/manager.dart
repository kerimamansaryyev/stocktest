import 'package:manager_provider/manager_provider.dart';
import 'package:meta/meta.dart';

class HomeManager extends Manager<HomeManagerState> {
  HomeManager() : super(const HomeManagerState._initial());
}

@immutable
class HomeManagerState {
  const HomeManagerState();

  const factory HomeManagerState._initial() = HomeManagerState;
}
