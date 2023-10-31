import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:llista_compra/models/llista_articles.dart';
import 'package:llista_compra/ui_widgets/comptador_enter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LlistaArticles(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Llista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llista compra'),
      ),
      body: const ElMeuBody(),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  const ElMeuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LlistaArticles>(builder: (context, model, _) {
            return TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                labelText: 'Ingresi un article',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  model.afegeix(Article(id: null, nom: text, quantity: 1));
                }
              },
            );
          }),
        ),
        Expanded(child: Consumer<LlistaArticles>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.count(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.itemAt(index).nom),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: ComptadorEnter(key: key, index: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                value.treu(value.itemAt(index));
                              },
                            ),
                          ],
                        )
                      ]),
                );
              },
            );
          },
        )),
      ],
    );
  }
}
