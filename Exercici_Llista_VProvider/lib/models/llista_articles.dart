import "package:flutter/material.dart";

class LlistaArticles extends ChangeNotifier {
  final List<Article> _articles = [];

  void afegeix(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void treu(Article article) {
    _articles.remove(article);
    notifyListeners();
  }

  Article itemAt(int index) {
    return _articles[index];
  }

  Article getByNom(String nom) {
    return _articles.firstWhere((article) => article.nom == nom);
  }

  int count() {
    return _articles.length;
  }
  void incrementa(Article article) {
    article.quantity++;
    notifyListeners();
  }

  void decrementa(Article article) {
    if (article.quantity > 1) {
      article.quantity--;
    }
    notifyListeners();
  }
}

class Article {
  int? id;
  String nom = "";
  int quantity = 0;

  Article({
    required this.id,
    required this.nom,
    required this.quantity,
  });
}
