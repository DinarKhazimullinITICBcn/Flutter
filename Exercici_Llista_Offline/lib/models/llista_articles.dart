import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LlistaArticles extends ChangeNotifier {
  static const serverPath = "http://dinarkhazimulliun.pythonanywhere.com";
  //static const serverPath = "http://localhost:5000";
  static String apiKey = "";
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse('$serverPath/articles'),
      headers: <String, String>{"x-api-key": apiKey},
    );

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Error al carregar les dades');
    }
  }

  Future<void> deleteArticle(int id) async {
    final response = await http.delete(
      Uri.parse('$serverPath/articles/$id'),
      headers: <String, String>{"x-api-key": apiKey},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      notifyListeners();
      return;
    } else {
      throw Exception('Error al carregar les dades');
    }
  }

  Future<void> afegeix(Article article) async {
    final response = await http.post(
      Uri.parse('$serverPath/articles'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': apiKey
      },
      body: article.toJson(),
    );
    if (response.statusCode == 201) {
      notifyListeners();
    } else {
      throw Exception('Error al crear el nou article!');
    }
  }

  Future<void> incrementa(Article article) async {
    final int id = article.id!;
    article.quantity++;
    final response = await http.put(
      Uri.parse('$serverPath/articles/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': apiKey
      },
      body: article.toJson(),
    );
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error al modificar l\'article!');
    }
  }

  void setApiKey(String valor) async {
    apiKey = valor;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("x_api_key", valor);
  }

  void guardarArticleCompra(Article article) async {
    String articleSP = article.toJson();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("article${article.id}", articleSP);
  }

  void decrementa(Article article) async {
    final int id = article.id!;
    if (article.quantity > 1) {
      article.quantity--;
    }
    final response = await http.put(
      Uri.parse('$serverPath/articles/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': apiKey
      },
      body: article.toJson(),
    );
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error al modificar l\'article!');
    }
  }

  Article getByNom(String nom) {
    // return _articles.firstWhere((article) => article.nom == nom);
    return Article(id: null, nom: "Article nul", quantity: 0);
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

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    quantity = json['quantitat'];
  }

  String toJson() {
    String data = "{";
    if (id != null) {
      data += '"id": $id, ';
    }
    data += '"nom": "$nom", "quantitat": $quantity}';
    return data;
  }
}
