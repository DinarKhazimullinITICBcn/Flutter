import 'package:flutter/material.dart';
import 'package:llista_compra/models/llista_articles.dart';
import 'package:provider/provider.dart';

class ComptadorEnter extends StatelessWidget {
  final int? index;
  // ignore: prefer_const_constructors_in_immutables
  ComptadorEnter({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<LlistaArticles> (
      builder: (context, LlistaArticles, _) {
        var article = LlistaArticles.itemAt(index ?? 0);
        var comptador = article.quantity;
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$comptador',
          ),
          Row(children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => LlistaArticles.incrementa(article),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => LlistaArticles.decrementa(article),
                ),
              ],
            )
          ]),
      ],
    );
      }
    ); 
  }
}
