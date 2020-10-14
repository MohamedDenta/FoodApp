class CartItemModel {
  String sId;
  String sUid;
  String sName;
  String sRestaurantId;
  int iPrice;
  String sImage;
  int iTotalRestaurantSale;
  int iQuantity;

  CartItemModel(
      {this.sId,
      this.sUid,
      this.sName,
      this.sRestaurantId,
      this.iPrice,
      this.sImage,
      this.iTotalRestaurantSale,
      this.iQuantity});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sUid = json['_uid'];
    sName = json['_name'];
    sRestaurantId = json['_restaurant_id'];
    iPrice = json['_price'];
    sImage = json['_image'];
    iTotalRestaurantSale = json['_total_restaurant_sale'];
    iQuantity = json['_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['_uid'] = this.sUid;
    data['_name'] = this.sName;
    data['_restaurant_id'] = this.sRestaurantId;
    data['_price'] = this.iPrice;
    data['_image'] = this.sImage;
    data['_total_restaurant_sale'] = this.iTotalRestaurantSale;
    data['_quantity'] = this.iQuantity;
    return data;
  }
}
