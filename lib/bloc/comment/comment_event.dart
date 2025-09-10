abstract class CommentEvent {}

class CommentInitializeEvent extends CommentEvent{
  String productId;
  CommentInitializeEvent(this.productId);
}