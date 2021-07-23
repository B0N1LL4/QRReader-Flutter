import 'package:flutter/material.dart';

import 'package:qrreader/src/pages/direcciones_page.dart';
import 'package:qrreader/src/pages/home_page.dart';
import 'package:qrreader/src/pages/mapa_page.dart';
import 'package:qrreader/src/pages/mapas_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'direcciones': (BuildContext context) => DireccionesPage(),
        'mapas': (BuildContext context) => MapasPage(),
        'mapa': (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
