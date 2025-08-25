import 'package:ecommerce/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
}

class BasketLocDatasource extends IBasketDatasource {
  final Box<BasketItem> box = Hive.box<BasketItem>('BasketItemBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (accumulator, product) => accumulator + product.realPrice!);

    return finalPrice;
  }
}
