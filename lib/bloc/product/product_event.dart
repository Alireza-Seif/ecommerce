abstract class ProductEvent {}

class ProductInitializedEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializedEvent(this.productId, this.categoryId);
}
