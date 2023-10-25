import 'package:flutter/material.dart';
import 'package:exercici_llista_icona/main.dart';

class ComptadorEnter extends StatefulWidget {
  const ComptadorEnter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ComptadorEnterState createState() => _ComptadorEnterState();
}

class _ComptadorEnterState extends State<ComptadorEnter> {
  int comptador = 1;

  void _incrementa() {
    setState(() {
      comptador++;
    });
  }

  void _decrementa() {
    setState(() {
      if (comptador > 1) {
        comptador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: _incrementa,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _decrementa,
              ),
            ],
          )
        ]),
      ],
    );
  }
}
