import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/comment_datasource.dart';
import 'package:ecommerce/data/model/comment_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>?>> getComments(String productId);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>?>> getComments(String productId) async {
    try {
      final response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }
}
