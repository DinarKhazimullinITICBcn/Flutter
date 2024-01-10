import 'package:flutter/material.dart';
import 'package:llista_compra/models/llista_articles.dart';
import 'package:provider/provider.dart';

class ComptadorEnter extends StatelessWidget {
  final Article article;

  const ComptadorEnter({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    return Consumer<LlistaArticles>(
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              article.quantity.toString(),
            ),
            Row(children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => value.incrementa(article),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => value.decrementa(article),
                  ),
                ],
              )
            ]),
          ],
        );
      },
    );
  }
}
