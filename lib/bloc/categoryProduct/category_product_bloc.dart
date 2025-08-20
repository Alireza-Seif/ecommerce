import 'package:ecommerce/bloc/categoryProduct/category_product_event.dart';
import 'package:ecommerce/bloc/categoryProduct/category_product_state.dart';
import 'package:ecommerce/data/repository/category_product_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitializeEvent>((event, emit) async {
      var response =
          await _repository.getProductsByCategoryId(event.categoryId);
      emit(CategoryProductResponseSuccessState(response));
    });
  }
}
