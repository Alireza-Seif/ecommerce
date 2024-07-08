abstract class HomeState {}

class InitHome extends HomeState {}

class UpdateHome extends HomeState {
  int x;
  UpdateHome(this.x);
}
