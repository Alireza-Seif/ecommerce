import 'package:ecommerce/bloc/category/category_event.dart';
import 'package:ecommerce/bloc/category/category_state.dart';
import 'package:ecommerce/data/repository/category_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryRequestEvent>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
