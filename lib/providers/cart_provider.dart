import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Map<String, int>> _carrinho = {};

  Map<String, Map<String, int>> get carrinho => _carrinho;

  void adicionarAoCarrinho(String nome, String tamanho) {
    if (!_carrinho.containsKey(nome)) {
      _carrinho[nome] = {"P": 0, "M": 0, "G": 0};
    }
    _carrinho[nome]![tamanho] = (_carrinho[nome]![tamanho] ?? 0) + 1;
    notifyListeners();
  }

  void removerDoCarrinho(String nome, String tamanho) {
    if (_carrinho.containsKey(nome) && _carrinho[nome]![tamanho]! > 0) {
      _carrinho[nome]![tamanho] = _carrinho[nome]![tamanho]! - 1;

      // Remove the pizza if all sizes are 0
      if (_carrinho[nome]!.values.every((qtd) => qtd == 0)) {
        _carrinho.remove(nome);
      }

      notifyListeners();
    }
  }

  double calcularTotal(List pizzas) {
    double total = 0;
    _carrinho.forEach((nome, tamanhos) {
      final pizza = pizzas.firstWhere((p) => p.nome == nome);
      tamanhos.forEach((tamanho, quantidade) {
        total += (pizza.precos[tamanho]! * quantidade);
      });
    });
    return total;
  }
}
