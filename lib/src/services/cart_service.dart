import 'package:flutter/foundation.dart';
import 'package:checkpoint_final/src/models/cart_item_model.dart';
import 'package:checkpoint_final/src/models/product_model.dart';

class CartService extends ChangeNotifier {
  // Singleton
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  String get formattedTotalPrice =>
      'R\$ ${totalPrice.toStringAsFixed(2).replaceAll('.', ',')}';

  void addProduct(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(product: product));
    }
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void increment(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrement(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_items[index].quantity <= 1) {
        _items.removeAt(index);
      } else {
        _items[index].quantity--;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
