import 'package:flutter/material.dart';
import 'package:food_app/scr/helpers/screen_navigation.dart';
import 'package:food_app/scr/helpers/style.dart';
import 'package:food_app/scr/providers/category.dart';
import 'package:food_app/scr/providers/product.dart';
import 'package:food_app/scr/providers/restaurant.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:food_app/scr/screens/home.dart';
import 'package:food_app/scr/screens/registration.dart';
import 'package:food_app/scr/widgets/custom_text.dart';
import 'package:food_app/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/logo.png",
                        width: 120,
                        height: 120,
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
                          controller: authProvider.email,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.email)),
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
                          maxLines: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(Icons.lock)),
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
                          var islogin = await authProvider.signIn();
                          if (authProvider.response.code != 200) {
                            islogin = false;
                          }
                          //islogin = false;
                          if (islogin) {
                            saveUserData(authProvider);
                            categoryProvider.loadCategories();
                            print("categoryProvider.response.message");
                            print(categoryProvider.response.message);
                            //restaurantProvider.loadSingleRestaurant();
                            //productProvider.loadProducts();
                            changeScreenReplacement(context, Home());
                          } else {
                            _key.currentState.showSnackBar(SnackBar(
                              content: Text(authProvider.response.message),
                            ));
                          }

                          authProvider.clearController();
                        } else {
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text(isValid),
                          ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: red,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Login",
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
                      changeScreen(context, RegistrationScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "Register here",
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

    if (!isEmail(bloc.email.text)) {
      return "email is not valid";
    }
    if (bloc.password.text.length < 8) {
      return "password must be at least 8 letters.";
    }
    return "";
  }

  Future<void> saveUserData(UserProvider authProvider) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("email", authProvider.response.user.email);
    prefs.setString("name", authProvider.response.user.name);
    prefs.setString("id", authProvider.response.user.id);
    prefs.setBool("login", true);
  }
}
