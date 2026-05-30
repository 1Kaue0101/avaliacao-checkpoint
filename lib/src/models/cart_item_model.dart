import 'package:checkpoint_final/src/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;

  String get formattedTotalPrice =>
      'R\$ ${totalPrice.toStringAsFixed(2).replaceAll('.', ',')}';
}
