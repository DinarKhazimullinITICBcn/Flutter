import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TextField y ListView',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField y ListView'),
      ),
      body: ElMeuBody(
        textEditingController: _textEditingController,
        addItemToList: _addItemToList,
        items: _items,
      ),
    );
  }
}

class ElMeuBody extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<String> items;
  final Function(String) addItemToList;

  ElMeuBody({
    required this.textEditingController,
    required this.items,
    required this.addItemToList,
  });

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
                  leading: Icon(Icons.star_half),
                  title: Text(items[index]),
                  trailing: SizedBox(height: 80, width:100, child: ComptadorEnter()
                  )  
              );
            }
          ),
        ),
      ],
    );
  }
}

class ComptadorEnter extends StatefulWidget  {
  _ComptadorEnterState createState() => _ComptadorEnterState();
}

class _ComptadorEnterState extends State<ComptadorEnter> {
  int comptador = 0;

  void _incrementa() {
    setState(() {
      comptador++;
    });
  }

  void _decrementa() {
    setState(() {
      if (comptador > 0) {
        comptador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$comptador'),
        Column(
          children: [
            IconButton(
              onPressed: _incrementa, 
              icon: Icon(Icons.add)
            ),
            IconButton(
              onPressed: _decrementa, 
              icon: Icon(Icons.remove)
            )
          ]
        ),
      ],
    );
  }
}