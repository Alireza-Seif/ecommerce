import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/comment_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
}

class CommentRemoteDatasource extends ICommentDatasource {
  @override
  Future<List<Comment>> getComments(String productId) async {
    final Dio dio = locator.get();
    Map<String, String> qParams = {'filter': 'product_id=$productId'};
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
}
