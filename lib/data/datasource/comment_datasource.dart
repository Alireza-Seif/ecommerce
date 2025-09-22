import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/comment_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends ICommentDatasource {
  final Dio dio = locator.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, String> qParams = {
      'filter': 'product_id=$productId',
      'expand': 'user_id'
    };
    try {
      var response = await dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromJason(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      final response = await dio.post('collections/users/records', data: {
        'text': comment,
        'user_id': 'test',
        'product_id': productId,
      });
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
