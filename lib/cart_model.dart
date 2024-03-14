class Cart{
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialprice;
  final int? productprice;
  final int? quantity;
  final String? unitTag;
  final String? image;


  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialprice,
    required this.productprice,
    required this.quantity,
    required this.unitTag,
    required this.image,
});

  Cart.fromMap(Map<dynamic, dynamic> res)
      :id = res['id'],
      productId = res["productId"],
      productName = res["productName"],
      initialprice = res["initialprice"],
      productprice = res["productprice"],
      quantity = res["quantity"],
      unitTag = res["unitTag"],
      image = res["image"];

  Map<String, Object?> toMap(){
    return{
      'id':id,
      'productId' : productId,
      'productName': productName,
      'initialprice': initialprice,
      'productprice': productprice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }
}