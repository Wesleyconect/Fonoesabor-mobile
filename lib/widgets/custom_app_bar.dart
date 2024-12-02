import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/carrinho_screen.dart';
import '../models/pizza_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final List<Pizza> pizzas;

  CustomAppBar({Key? key, required this.pizzas})
      : preferredSize = const Size.fromHeight(60),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return AppBar(
      title: Row(
        children: [
          Image.asset('lib/assents/logo.png', width: 40, height: 40),
          const SizedBox(width: 10),
          const Text('Forno e Sabor', style: TextStyle(fontSize: 24)),
        ],
      ),
      backgroundColor: Colors.red,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarrinhoScreen(pizzas: pizzas),
                  ),
                );
              },
            ),
            if (cart.carrinho.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${cart.carrinho.values.fold(0, (sum, sizes) => sum + sizes.values.reduce((a, b) => a + b))}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
