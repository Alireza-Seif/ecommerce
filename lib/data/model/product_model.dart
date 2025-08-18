class ProductModel {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;
  int? realPrice;
  num? percent;

  ProductModel(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.categoryId,
  ) {
     realPrice = price - discountPrice;
     percent = ((price - realPrice!) / price) * 100;
  }

  factory ProductModel.fromJson(Map<String, dynamic> jsonObject) {
    return ProductModel(
      jsonObject['id'],
      jsonObject['collectionId'],
      'https://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['description'],
      jsonObject['discount_price'],
      jsonObject['price'],
      jsonObject['popularity'],
      jsonObject['name'],
      jsonObject['quantity'],
      jsonObject['category'],
    );
  }
}
