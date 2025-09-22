abstract class CommentEvent {}

class CommentInitializeEvent extends CommentEvent {
  String productId;
  CommentInitializeEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  final String productId;
  final String comment;

  CommentPostEvent(this.productId, this.comment);
}
