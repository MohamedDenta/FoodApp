import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/scr/helpers/screen_navigation.dart';
import 'package:food_app/scr/helpers/style.dart';
import 'package:food_app/scr/models/products.dart';
import 'package:food_app/scr/providers/product.dart';
import 'package:food_app/scr/providers/restaurant.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:food_app/scr/screens/restaurant.dart';
import 'package:food_app/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'custom_text.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isFavored = false;

  //double rating;

  @override
  Widget build(BuildContext context) {
    // if(rating==null){
    //   print('000000000000000000');
    //   rating = widget.product.iRates.toDouble();
    // }
    final userProvider = Provider.of<UserProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    //checkIsLiked(widget.product.sId);
    if (widget.product.bLiked == null) {
      // print("like is null ......");
      widget.product.bLiked = isFavored;
      // print(widget.product.bLiked);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        // width: MediaQuery.of(context).size.width * 5,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
        //            height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.product.sImage,
                  placeholder: (_, s) => Center(child: Loading()),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        // padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomText(
                            text: widget.product.sName,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(1, 1),
                                    blurRadius: 4),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                widget.product.bLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: green,
                                size: 18,
                              ),
                              onPressed: () async {
                                setState(() {
                                  isFavored = !isFavored;
                                  widget.product.bLiked = isFavored;
                                });

                                var prefs =
                                    await SharedPreferences.getInstance();
                                userProvider
                                    .likeDisLike(widget.product.sId,
                                        prefs.getString("id"))
                                    .then((fine) {
                                  if (fine) {
                                    print("like success ........");
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: <Widget>[
                        CustomText(
                          text: "from: ",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await productProvider.loadProductsByRestaurant(
                                restaurantId:
                                    widget.product.sRestaurantId.toString(),
                                userId: prefs.getString("id"));
                            await restaurantProvider.loadSingleRestaurant(
                                retaurantId:
                                    widget.product.sRestaurantId.toString());

                            changeScreen(
                                context,
                                RestaurantScreen(
                                  restaurantModel:
                                      restaurantProvider.restaurant,
                                ));
                          },
                          child: restaurantProvider.restaurant?.sId ==
                                  widget.product.sRestaurantId
                              ? CustomText(
                                  text: restaurantProvider.restaurant.sName,
                                  color: primary,
                                  weight: FontWeight.bold,
                                  size: 14,
                                )
                              : FlatButton(
                                  child: Text("show "),
                                  onPressed: () async {
                                    await restaurantProvider
                                        .loadSingleRestaurant(
                                            retaurantId: widget
                                                .product.sRestaurantId
                                                .toString());
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // CustomText(
                          //   text: widget.product.iRating.toString(),
                          //   color: grey,
                          //   size: 14.0,
                          // ),
                          SizedBox(
                            width: 2,
                          ),

                          Container(
                            height: 18,
                            child: SmoothStarRating(
                              rating: widget.product.iRates.toDouble(),
                              isReadOnly: false,
                              size: 20,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: false,
                              spacing: 2.0,
                              onRated: (value) async {
                                print("rating value -> $value");
                                var p = widget.product;
                                p.iRating = value.toInt();
                                print(p.toJson().toString());
                                var prefs =
                                    await SharedPreferences.getInstance();
                                bool c = await productProvider.updateRate(
                                    prodId: p.sId,
                                    userId: prefs.getString("id"),
                                    rate: value.toInt());
                                c
                                    ? print("aaaaaaaaaaaaaaaaaaaaaaaaa")
                                    : print("bbbbbbbbbbbbbbbbbbb");
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "\$${widget.product.iPrice / 100}",
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
