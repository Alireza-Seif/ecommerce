import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/category_model.dart';

abstract class CategoryState {
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends  CategoryState {}

class CategoryResponseState extends CategoryState{
  Either<String, List<CategoryModel>> response;
  CategoryResponseState(this.response);
}