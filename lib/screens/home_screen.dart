import 'package:flutter/material.dart';
import '../models/pizza_model.dart';
import '../widgets/custom_app_bar.dart';
import 'bebidas_screen.dart';
import 'pedidos_screen.dart';
import 'conta_screen.dart';
import 'pizzas_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PizzasPage(),
    BebidasPage(),
    PedidosScreen(),
    ContaScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pizzas = [
      Pizza(
        nome: "Portuguesa",
        descricao: "Presunto, milho, palmito, azeitona, ovo, cebola e orégano",
        imagem: "lib/assets/portuguesa.png",
        precos: {"P": 32.0, "M": 45.0, "G": 70.0},
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(pizzas: pizzas),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pizza), label: 'Pizzas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_drink), label: 'Bebidas'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Conta'),
        ],
      ),
    );
  }
}
