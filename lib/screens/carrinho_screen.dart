import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza_model.dart';
import '../providers/cart_provider.dart';

class CarrinhoScreen extends StatelessWidget {
  final List<Pizza> pizzas;

  CarrinhoScreen({required this.pizzas});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Carrinho'), backgroundColor: Colors.red),
      body: cart.carrinho.isEmpty
          ? Center(child: Text("Seu carrinho está vazio!"))
          : ListView(
              children: cart.carrinho.entries.map((entry) {
                final nome = entry.key;
                final tamanhos = entry.value;

                // Encontrar pizza correspondente
                final pizza = pizzas.firstWhere(
                  (p) => p.nome == nome,
                  orElse: () => Pizza(
                    nome: nome,
                    descricao: 'Pizza não encontrada',
                    imagem: '',
                    precos: {"P": 0.0, "M": 0.0, "G": 0.0},
                  ),
                );

                return Card(
                  child: Column(
                    children: tamanhos.entries
                        .where((e) =>
                            e.value >
                            0) // Exibe apenas tamanhos com quantidade > 0
                        .map((tamanhoEntry) {
                      final tamanho = tamanhoEntry.key;
                      final quantidade = tamanhoEntry.value;

                      return ListTile(
                        title: Text('${pizza.nome} - $tamanho'),
                        subtitle: Text(pizza.descricao),
                        trailing: Text(
                          'Qtd: $quantidade | Total: R\$ ${(pizza.precos[tamanho]! * quantidade).toStringAsFixed(2)}',
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: R\$ ${cart.calcularTotal(pizzas).toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                print("Pedido finalizado!");
              },
              child: Text("Finalizar"),
            )
          ],
        ),
      ),
    );
  }
}
