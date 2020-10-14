import 'package:flutter/material.dart';
import 'package:food_app/scr/helpers/screen_navigation.dart';
import 'package:food_app/scr/helpers/style.dart';
import 'package:food_app/scr/models/user.dart';
import 'package:food_app/scr/providers/category.dart';
import 'package:food_app/scr/providers/product.dart';
import 'package:food_app/scr/providers/restaurant.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:food_app/scr/screens/login.dart';
import 'package:food_app/scr/widgets/custom_text.dart';
import 'package:food_app/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Text(
                        "plants market",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/logo.png",
                        width: 100,
                        height: 100,
                        color: green,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          maxLines: 1,
                          controller: authProvider.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            icon: Icon(
                              Icons.person,
                              color: green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.email,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(
                                Icons.email,
                                color: green,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.password,
                          obscureText: true,
                          maxLines: 1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: green,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        var isValid = validate(context);
                        if (isValid == "") {
                          var res = await authProvider.signUp(context);
                          if (res.code != 200) {
                            _key.currentState.showSnackBar(SnackBar(
                                content: ListTile(
                              title: Text(res.type),
                              subtitle: Text(res.message),
                            )));
                            return;
                          } else {
                            authProvider.clearController();
                            changeScreenReplacement(context, LoginScreen());
                          }
                          //categoryProvider.loadCategories();
                          //restaurantProvider.loadSingleRestaurant();
                          //productProvider.loadProducts();
                        } else {
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text(isValid),
                          ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: green,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Resgister",
                                color: white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "login",
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String validate(BuildContext context) {
    var bloc = Provider.of<UserProvider>(context, listen: false);
    if (bloc.name.text.length < 4) {
      return "user name must be at least 4 letters.";
    }
    if (isInt(bloc.name.text)) {
      return "name is not valid";
    }
    if (!isEmail(bloc.email.text)) {
      return "email is not valid";
    }
    if (isLength(bloc.password.text, 8)) {
      return "password must be at least 8 letters.";
    }
    return "";
  }
}
