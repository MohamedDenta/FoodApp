class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";

  String sId;
  String sName;
  String sRestaurantId;
  String sCategory;
  String sImage;
  String sDescription;
  int iRating;
  int iPrice;
  int iRates;
  bool bFeatured;
  bool bLiked;

  ProductModel({
    this.sId,
    this.sName,
    this.sRestaurantId,
    this.sCategory,
    this.sImage,
    this.sDescription,
    this.iRating,
    this.iPrice,
    this.iRates,
    // this.bFeatured,
    // this.bLiked
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sName = json['_name'];
    sRestaurantId = json['_restaurant_id'];
    sCategory = json['_category'];
    sImage = json['_image'];
    sDescription = json['_description'];
    iRating = json['_rating'];
    iPrice = json['_price'];
    iRates = json['_rates'];
    bFeatured = json['_featured'];
    bLiked = json['_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['_name'] = this.sName;
    data['_restaurant_id'] = this.sRestaurantId;
    data['_category'] = this.sCategory;
    data['_image'] = this.sImage;
    data['_description'] = this.sDescription;
    data['_rating'] = this.iRating;
    data['_price'] = this.iPrice;
    data['_rates'] = this.iRates;
    // data['_featured'] = this.bFeatured;
    // data['_liked'] = this.bLiked;
    return data;
  }
}
