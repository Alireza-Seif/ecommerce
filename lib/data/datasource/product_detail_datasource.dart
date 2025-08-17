import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';
import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImageModel>> getGallery();
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariant();
  Future<List<ProductVariant>> getProductVariants();
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImageModel>> getGallery() async {
    try {
      Map<String, dynamic> qParams = {'filter': 'product_id="78n4wqor3hhnkju"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductImageModel>(
              (jsonObject) => ProductImageModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Variant>> getVariant() async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="5vvww65pv6nviw6"'};
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants() async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariant();

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList) {
     var variant = variantList.where((element) => element.typeId == variantType.id).toList();

      productVariantList.add(ProductVariant(variantType, variant));
    }
    return productVariantList;
  }
}
