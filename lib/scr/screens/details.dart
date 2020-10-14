import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/scr/helpers/screen_navigation.dart';
import 'package:food_app/scr/models/products.dart';
import 'package:food_app/scr/providers/app.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:food_app/scr/screens/cart.dart';
import 'package:food_app/scr/widgets/custom_text.dart';
import 'package:food_app/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/style.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              user.getCart(id: "id", uid: prefs.getString("id"));
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: CachedNetworkImageProvider(
                      widget.product.sImage,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: widget.product.sName,
                      size: 26,
                      weight: FontWeight.bold),
                  CustomText(
                      text: "\$${widget.product.iPrice / 100}",
                      size: 20,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "Description", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.sDescription,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 36,
                            ),
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          print("All set loading");
                          var prefs = await SharedPreferences.getInstance();

                          var value = await user.addToCard(
                              product: widget.product,
                              quantity: quantity,
                              userId: prefs.getString("id"));
                          if (value == "") {
                            print("Item added to cart");
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("Added to Cart!")));
                            // user.reloadUserModel();
                            app.changeLoading();
                            Navigator.of(context).pop(true);
                            return;
                          } else {
                            print("Item NOT added to cart");
                            print("Item not added to cart");
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text(value)));
                            user.reloadUserModel();
                            app.changeLoading();
                          }
                          print("lOADING SET TO FALSE");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Add $quantity To Cart",
                                    color: white,
                                    size: 22,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 36,
                              color: green,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
