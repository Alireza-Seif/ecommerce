import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/basket_datasource.dart';
import 'package:ecommerce/data/model/basket_item.dart';
import 'package:ecommerce/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItem();
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      _datasource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItem() async {
    try {
      var basketItemList = await _datasource.getAllBasketItem();
      return Right(basketItemList);
    } catch (ex) {
      return Left(ex.toString());
    }
  }
}
