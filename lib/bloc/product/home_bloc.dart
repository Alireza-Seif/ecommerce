import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/product/home_event.dart';
import 'package:ecommerce/bloc/product/home_state.dart';

class HomeBloc extends Bloc<ClickEvent, HomeState> {
  int x = 0;
  HomeBloc() : super(InitHome()) {
    on<ClickEvent>((event, emit) {
      emit(UpdateHome(x++));
    });
  }
}
