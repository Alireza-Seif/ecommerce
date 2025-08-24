import 'package:ecommerce/data/model/product_model.dart';

abstract class ProductEvent {}

class ProductInitializedEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializedEvent(this.productId, this.categoryId);
}

class ProductAddToBasket extends ProductEvent {
  Product product;
  ProductAddToBasket(this.product);
}
