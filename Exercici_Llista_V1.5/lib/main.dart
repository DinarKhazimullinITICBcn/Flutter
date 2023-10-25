import 'package:flutter/material.dart';
import 'package:exercici_llista_icona/ui_widgets/comptador_enter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Llista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = [];

  void _addItemToList(String newItem) {
    setState(() {
      _items.add(newItem);
      _textEditingController.clear();
    });
  }

  void _removeItemFromList(String esborrat) {
    setState(() {
      _items.remove(esborrat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Llista compra'),
      ),
      body: ElMeuBody(
        textEditingController: _textEditingController,
        addItemToList: _addItemToList,
        items: _items,
        removeItemFromList: _removeItemFromList,
      ),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<String> items;
  final Function(String) addItemToList;
  final Function(String) removeItemFromList;

  ElMeuBody({
    required this.textEditingController,
    required this.items,
    required this.addItemToList,
    required this.removeItemFromList,
  });

  void removeItem(String nom) {
    removeItemFromList(nom);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Ingresi un article',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                addItemToList(text);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(0.0),
                            child: ComptadorEnter(),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => {removeItem(items[index])},
                          )
                        ]
                      )
                    ]),
              );
            },
          ),
        ),
      ],
    );
  }
}