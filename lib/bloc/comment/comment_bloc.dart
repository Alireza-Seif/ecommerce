import 'package:ecommerce/bloc/comment/comment_event.dart';
import 'package:ecommerce/bloc/comment/comment_state.dart';
import 'package:ecommerce/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository repository;
  CommentBloc(this.repository) : super(CommentLoading()) {
    on<CommentInitializeEvent>((event, emit) async {
      final response = await repository.getComments(event.productId);
      emit(CommentResponse(response));
    });
  }
}
