class Linkapi {
  static const String Api = "http://20.0.7.207/ecommerceapp";

  ////////////////////////auth//////////////////////////////
  static const String signupl = "$Api/auth/signin.php";
  static const String verifiedcodesignup = "$Api/auth/verfiecationcode.php";
  static const String resendcode = "$Api/auth/resendcode.php";
  static const String loginapi = "$Api/auth/login.php";

  ////////////////////////forgetpassword//////////////////////////////
  static const String forgetpasswordlink =
      "$Api/auth/forgetpassword/forgetpassword.php";
  static const String checkcodelogin =
      "$Api/auth/forgetpassword/checkcodelogin.php";
  static const String resetpass = "$Api/auth/forgetpassword/resetpassword.php";
  static const String banner = "$Api/home/getbanner.php";
  static const String items = "$Api/home/getitems.php";
  static const String itemsForCategory =
      "$Api/itemsfor_category/items_Category.php";

  static const String rimages = "$Api/image";
  static const String homecategoty = "$Api/home/getcategory.php";

  ////////////////////////  favorite   ///////////////////////////

  static const String favv = "$Api/favorite.php";
  static const String viewfavv = "$Api/viewfavorite.php";
  static const String viewfavvnosearch = "$Api/viewfavoritenosearch.php";

  ////////////////////////  SEARCH   ///////////////////////////
  static const String Search = "$Api/Search/Searchitems.php";
  static const String Searchhistory = "$Api/Search/Searchhistory.php";
  static const String getistory = "$Api/Search/gethistory.php";

  static const String clearhist = "$Api/Search/clearhistory.php";
  static const String deleteidhist = "$Api/Search/deleteidhistory.php";
  static const String popularsearch = "$Api/Search/popularsearch.php";

  static const String Getcolorandlocation = "$Api/getcolorandlocation.php";

  static const String Filterby = "$Api/Search/FilterBy.php";

  ////////////////////////  CART   ///////////////////////////
  static const String deleteitocart = "$Api/cart/delete.php";

  static const String inserintocart = "$Api/cart/insert.php";
  static const String viewvart = "$Api/cart/viewcart.php";

  static const String viewitems_color = "$Api/viewitems_color.php";
  static const String viewcoupondetails = "$Api/cart/viewcoupondetails.php";

  ////////////////////////  Addres   ///////////////////////////
  static const String viewaddres = "$Api/addres/viewaddres.php";
  static const String addaddres = "$Api/addres/ِAdd_Addres.php";
  static const String viewlatestaddres = "$Api/addres/viewlatestaddrse.php";
  static const String chckoutorderelink = "$Api/chckoutorders/checkout.php";

  ////////////////////////  Payment   ///////////////////////////
  static const String paymentRequest = "$Api/Payment_integeration/payment.php";
  static const String payfaster = "$Api/Payment_integeration/pay_payment.php";

  static const String getnumbercart =
      "$Api/getinformationcard/getinformation.php";
  ////////////////////////Orders//////////////////////////////
  static const String getorders = "$Api/orders/getorder.php";
  ////////////////////////Profile////////////////////////////
  static const String updateprofiel = "$Api/profile/update_profile.php";
  static const String updateImage = "$Api/profile/update_image.php";
  static const String getProfile = "$Api/profile/get_profile.php";
  static const String changePassword = "$Api/profile/change_password.php";
}
