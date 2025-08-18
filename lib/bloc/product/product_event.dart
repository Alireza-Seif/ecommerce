abstract class ProductEvent {}


class ProductInitializedEvent extends ProductEvent{
   String productId;
   ProductInitializedEvent(this.productId); 
}