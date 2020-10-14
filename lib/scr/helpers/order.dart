import 'package:food_app/scr/models/cart_item.dart';
import 'package:food_app/scr/models/order.dart';

class OrderServices {
  String collection = "orders";
  void createOrder(
      {String userId,
      String id,
      String description,
      String status,
      List<CartItemModel> cart,
      int totalPrice}) {
    List<Map> convertedCart = [];
    List<String> restaurantIds = [];

    for (CartItemModel item in cart) {
      convertedCart.add(item.toJson());
      restaurantIds.add(item.sRestaurantId);
    }

    // _firestore.collection(collection).document(id).setData({
    //   "userId": userId,
    //   "id": id,
    //   "restaurantIds": restaurantIds,
    //   "cart": convertedCart,
    //   "total": totalPrice,
    //   "createdAt": DateTime.now().millisecondsSinceEpoch,
    //   "description": description,
    //   "status": status
    // });
  }

  List<OrderModel> getUserOrders({String userId}) {
    return [];
    // _firestore
    //     .collection(collection)
    //     .where("userId", isEqualTo: userId)
    //     .getDocuments()
    //     .then((result) {
    //   List<OrderModel> orders = [];
    //   for (DocumentSnapshot order in result.documents) {
    //     orders.add(OrderModel.fromSnapshot(order));
    //   }
    //   return orders;
    // });
  }
}
