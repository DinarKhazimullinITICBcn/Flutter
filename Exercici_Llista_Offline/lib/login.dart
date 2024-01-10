import 'package:flutter/material.dart';
import 'package:llista_compra/main.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:llista_compra/models/llista_articles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});
  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final _formKey = GlobalKey<FormState>();
  static String serverPath = LlistaArticles.serverPath;
  TextEditingController usuariController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      String? apiKey = prefs.getString("x_api_key");
      if (apiKey != null) {
        print("Tenim api_key $apiKey");
        var llista = LlistaArticles();
        llista.setApiKey(apiKey);
        llista.fetchArticles().then((articles) {
        // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        }).catchError((_) => null);
      }
    });
  }

  void login(String email, String password, BuildContext context) async {
    try {
      String credentials = base64.encode(utf8.encode('$email:$password'));
      String authHeader = 'Basic $credentials';
      Response response = await post(
        Uri.parse('$serverPath/login'),
        headers: {'Authorization': authHeader},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = jsonDecode(response.body.toString());
        var llista = LlistaArticles();
        llista.setApiKey(data['x-api-key']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ha fallat la autenticació!')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pàgina de login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: usuariController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Usuari"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Camp obligatori!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Camp obligatori';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login(usuariController.text, passwordController.text,
                          context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
