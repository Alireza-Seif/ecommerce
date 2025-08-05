class ProductImageModel {
  String? imageUrl;
  String? productUrl;

  ProductImageModel(this.imageUrl, this.productUrl);

  factory ProductImageModel.fromJson(Map<String, dynamic> jsonObject) {
    return ProductImageModel(
      'https://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
