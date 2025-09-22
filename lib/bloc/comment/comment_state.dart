import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/comment_model.dart';

abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  Either<String, List<Comment>> response;
  CommentResponse(this.response);
}

class CommentPostLoading extends CommentState {
  final bool isLoading;

  CommentPostLoading(this.isLoading);
}

class CommentPostResponse extends CommentState {
  final Either<String, String> response;

  CommentPostResponse(this.response);
}
