import 'package:ecommerce/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
}

class BasketLocDatasource extends IBasketDatasource {
  var box = Hive.openBox<BasketItem>('BasketItemBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.then((box) => box.add(basketItem));
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.then((box) => box.values.toList());
  }
}
