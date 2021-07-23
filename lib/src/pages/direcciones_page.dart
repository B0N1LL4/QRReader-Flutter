import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }
        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (direccion) {
                  scansBloc.borrarScans(scans[i].id);
                },
                background: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                key: UniqueKey(),
                child: ListTile(
                  onTap: () => utils.abrirScan(context, scans[i]),
                  leading: Icon(
                    Icons.http,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[i].valor),
                  subtitle: Text('ID: ${scans[i].id}'),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ),
              );
            });
      },
    );
  }
}
