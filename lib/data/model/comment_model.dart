class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumbnailUrl;
  String userName;

  Comment(this.id, this.text, this.productId, this.userId,
      this.userThumbnailUrl, this.userName);

  factory Comment.fromJason(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['product_id'],
      jsonObject['user_id'],
      'http://startflutter.ir/api/files/${jsonObject['expand']['user-id']['collectionName']}/${jsonObject['expand']['user-id']['id']}/${jsonObject['expand']['user-id']['avatar']}',
      jsonObject['expand']['user-id']['name'],
    );
  }
}
