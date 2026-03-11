import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

// Definim la funció funcioAsíncrona que fa una petició HTTP real
// i retorna el contingut de la resposta com a String

Future<Map<String, dynamic>> funcioAsincrona() async {
  String url = "http://10.0.2.2:3000/api/usuaris";

  try {
    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);
      print(bodyJSON);

      return bodyJSON;
    }
  } on Exception catch (e) {
    print(e);
  }
  // Return empty map if request fails
  return {};
}

// Giny principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemple amb FutureBuilder',
      home: Scaffold(
        appBar: AppBar(title: const Text('Exemple amb FutureBuilder')),
        body: const Center(child: GinyAsincron()),
      ),
    );
  }
}

// Aquest giny es construirà en base a un
// FutureBuilder vingulat a la funció asíncrona.

class GinyAsincron extends StatelessWidget {
  const GinyAsincron({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: funcioAsincrona(),
      initialData: "Esperant resposta...",
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: snapshot.data,
          itemBuilder: (BuildContext context, int index) {
            return Text(snapshot.data);
          },
        );
      },
    );
  }
}
