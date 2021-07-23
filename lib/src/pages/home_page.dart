import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';

import 'package:qrreader/src/pages/direcciones_page.dart';
import 'package:qrreader/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreader/src/providers/db_provider.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              onPressed: () {
                scansBloc.borrarTodosScans();
              })
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQR(context),
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    //   // https://cdn.website.dish.co/media/d9/53/2410633/Donde-Paqui-Carta-Donde-Paqui.pdf
    //   // geo:40.73255860802501,-73.89333143671877
    dynamic futureString = '';

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString.rawContent = e.toString();
    }

    if (futureString != null) {
      final scan = ScanModel(valor: futureString.rawContent);
      scansBloc.agregarScans(scan);
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 800));
        utils.abrirScan(context, scan);
      } else {
        utils.abrirScan(context, scan);
      }
      // DBProvider.db.nuevoScan(scan);
    } else {
      return print('No se pudo leer bien');
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigatorBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Mapa'),
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            title: Text('Direcciones'),
            icon: Icon(Icons.brightness_5),
          ),
        ]);
  }
}
