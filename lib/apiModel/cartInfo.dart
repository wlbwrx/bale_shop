class CartInfoModel{
  int productId;

  String productTitle;

  int quantity;

  int productSkuId;

  String productSkuBarcode;

  String productSkuName;

  String productImageUrl;

  bool isSelect;

  double productPrice;

  double originalPrice;
  
  double discountPrice;

  int shoppingType;
  
  bool isLimitProduct;

  CartInfoModel({this.productId,this.productTitle,this.quantity,this.productSkuId,this.productSkuBarcode,this.productSkuName,this.productImageUrl,this.isSelect,this.productPrice,this.originalPrice,this.discountPrice,this.shoppingType,this.isLimitProduct});

  CartInfoModel.formJson(Map<String,dynamic> json){
      productId = json['productId'];
      productTitle = json['productTitle'];
      quantity = json['quantity'];
      productSkuId = json['productSkuId'];
      productSkuBarcode = json['productSkuBarcode'];
      productSkuName = json['productSkuName'];
      productImageUrl = json['productImageUrl'];
      isSelect = json['isSelect'];
      productPrice = json['productPrice'];
      originalPrice = json['originalPrice'];
      discountPrice = json['discountPrice'];
      shoppingType = json['shoppingType'];
      isLimitProduct = json['isLimitProduct'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data["productId"] = this.productId;
    data["productTitle"] = this.productTitle;
    data["quantity"] = this.quantity;
    data["productSkuId"] = this.productSkuId;
    data["productSkuBarcode"] = this.productSkuBarcode;
    data["productSkuName"] = this.productSkuName;
    data["productImageUrl"] = this.productImageUrl;
    data["isSelect"] = this.isSelect;
    data["productPrice"] = this.productPrice;
    data["originalPrice"] = this.originalPrice;
    data["discountPrice"] = this.discountPrice;
    data["shoppingType"] = this.shoppingType;
    data["isLimitProduct"] = this.isLimitProduct;
    return data;
  }
}