import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/scr/helpers/app.dart';
import 'package:food_app/scr/helpers/screen_navigation.dart';
import 'package:food_app/scr/models/products.dart';
import 'package:food_app/scr/providers/app.dart';
import 'package:food_app/scr/providers/product.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:food_app/scr/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products?.length ?? 0,
          itemBuilder: (_, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(
                        _,
                        Details(
                          product: productProvider.products[index],
                        ));
                  },
                  child: Container(
                    height: 220,
                    width: 200,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Stack(
                            children: <Widget>[
                              // Positioned.fill(
                              //     child: Align(
                              //   alignment: Alignment.center,
                              //   child: Loading(),
                              // )),
                              Center(
                                child: CachedNetworkImage(
                                  placeholder: (_, s) => Center(
                                    child: Loading(),
                                  ),
                                  imageUrl:
                                      productProvider.products[index].sImage,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              //padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                text: productProvider.products[index].sName ??
                                    "id null",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
//                                  setState(() {
//                                    productProvider.products[index].liked = !productProvider.products[index].liked;
//                                  });
//                                  productProvider.likeDislikeProduct(userId: user.userModel.id, product: productProvider.products[index], liked: productProvider.products[index].liked);
                                },
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 8.0),
                                //   child: CustomText(
                                //     text: productProvider.products[index].iRates
                                //         .toString(),
                                //     color: grey,
                                //     size: 14.0,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 2,
                                ),
                                // Icon(
                                //   Icons.star,
                                //   color: red,
                                //   size: 16,
                                // ),
                                // Icon(
                                //   Icons.star,
                                //   color: red,
                                //   size: 16,
                                // ),
                                // Icon(
                                //   Icons.star,
                                //   color: red,
                                //   size: 16,
                                // ),
                                // Icon(
                                //   Icons.star,
                                //   color: grey,
                                //   size: 16,
                                // ),
                                Container(
                                  height: 18,
                                  child: SmoothStarRating(
                                    rating: productProvider
                                        .products[index].iRates
                                        .toDouble(),
                                    isReadOnly: false,
                                    size: 20,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: false,
                                    spacing: 2.0,
                                    onRated: (value) async {
                                      print(
                                          "rating value -> ${productProvider.products[index].iRates}");
                                      var p = productProvider.products[index];
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
                                text:
                                    "\$${productProvider.products[index].iPrice / 100}",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
