# #############  USER APIs ################
# Signup API
* Request JSON
  {
      email
      name
      password
  }
* response JSON
{
    code
    message
}
**********************
# Signin API
* Request JSON
  {
      email
      password
  }
* response JSON
{
    code
    message
}
**********************
# signout API
* Request JSON
  {
      email
      password
  }
* response JSON
{
    code
    message
}
**********************
# addToCard API
* Request JSON
  {
    ID 
    NAME 
    RATING 
    IMAGE 
    PRICE 
    RESTAURANT_ID 
    RESTAURANT 
    DESCRIPTION 
  }
* response JSON
{
    code
    message
}
**********************
# getOrders API
* Request JSON
  {
    UserID
  }
* response JSON
{
    []Orders
    code
    message
}
**********************
# removeFromCart API
* Request JSON
  {
    UserID
    ItemID
  }
* Response JSON
{
    code
    message
}
********************************************************
# #############  RESTAURANTS APIs ################
# getallrestaurants API
* Request JSON
  {
    UserID
  }
* Response JSON
{
    [] restaurants
    code
    message
}
# getsinglerestaurant API
* Request JSON
  {
    UserID
    resID
  }
* Response JSON
{
    restaurant
    code
    message
}
# search API
* Request JSON
  {
    keyword
  }
* Response JSON
{
    [] restaurants
    code
    message
}
# #############  product APIs ################
# getallproducts API
* Request JSON
  {
    UserID
  }
* Response JSON
{
    [] products
    code
    message
}
# searchbycategory API
* Request JSON
  {
    UserID
    Category
  }
* Response JSON
{
    [] products
    code
    message
}
# searchbyrestaurant API
* Request JSON
  {
    UserID
    restaurant
  }
* Response JSON
{
    [] products
    code
    message
}
# search API
* Request JSON
  {
    UserID
    keyword
  }
* Response JSON
{
    [] products
    code
    message
}
# #############  category APIs ################
# getallcategories
* Request JSON
  {
    UserID
  }
* Response JSON
{
    [] categories
    code
    message
}
