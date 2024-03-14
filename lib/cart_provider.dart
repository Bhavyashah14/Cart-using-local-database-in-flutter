import 'package:cart/cart_model.dart';
import 'package:cart/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{

  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalprice = 0.0;
  double get totalprice => _totalprice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData () async{
    _cart = db.getCartList();
    return _cart;
  }


  void _setPrefItems()async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    Prefs.setInt('cart_item',_counter);
    Prefs.setDouble('total_price', _totalprice);
    notifyListeners();
  }
  void _getPrefItems()async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    _counter = Prefs.getInt('cart_item') ?? 0;
    _totalprice = Prefs.getDouble('cart_item') ?? 0.0;

    notifyListeners();
  }

  void addTotalPrice(double productPrice){
    _totalprice = _totalprice + productPrice;
    _setPrefItems();
    notifyListeners();
  }
  void removeTotalPrice(double productPrice){
    _totalprice = _totalprice - productPrice;
    _setPrefItems();
    notifyListeners();
  }
  double getTotalPrice(){
    _getPrefItems();
    return _totalprice;

  }

  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
}
  void removerCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }
  int getCounter(){
    _getPrefItems();
    return _counter--;

  }


}
