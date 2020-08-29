import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:llista_de_la_compra/pages/edit_compra.dart';

// ignore: must_be_immutable
class CompraView extends StatefulWidget {
  CompraView({this.compra});
  Map<String, dynamic> compra;

  @override
  _CompraViewState createState() => _CompraViewState();
}

class _CompraViewState extends State<CompraView> {
  String readTimestamp(int timestamp) {
    if (timestamp == null) return null;

    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    String str = date.day.toString().padLeft(2, "0") +
        "/" +
        date.month.toString().padLeft(2, "0") +
        "/" +
        date.year.toString() +
        " " +
        date.hour.toString().padLeft(2, "0") +
        ":" +
        date.minute.toString().padLeft(2, "0");

    return str;
  }

  @override
  Widget build(BuildContext context) {
    final String key = widget.compra['key'];
    final bool comprat = widget.compra['comprat'];
    final String nom = widget.compra['nom'];
    final String tipus = widget.compra['tipus'];
    final String prioritat = widget.compra['prioritat'];
    final int quantitat = widget.compra['quantitat'];
    final int preuEstimat = widget.compra['preuEstimat'];

    String strDataPrevista;
    final Timestamp dataPrevista = widget.compra['dataPrevista'];
    if (dataPrevista != null)
      strDataPrevista = readTimestamp(dataPrevista.seconds);

    String strDataCreacio;
    final Timestamp dataCreacio = widget.compra['dataCreacio'];
    if (dataCreacio != null)
      strDataCreacio = readTimestamp(dataCreacio.seconds);

    return Scaffold(
      appBar: AppBar(
        title: Text('Propietats de la compra'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              dynamic resposta = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCompra(compra: widget.compra),
                ),
              );
              if (resposta != null) {
                DocumentReference doc =
                    FirebaseFirestore.instance.collection('productes').doc(key);
                doc.update(resposta);
              }
              setState(() {
                widget.compra = resposta;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Nom: $nom",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Tipus: $tipus",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Quantitat: $quantitat",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Prioritat: $prioritat",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Preu estimat: ${preuEstimat ?? "No assignat"}",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Comprat: ${comprat ? 'SI' : 'NO'}",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Data Prevista: ${strDataPrevista ?? "No assignada"}",
              style: TextStyle(fontSize: 25),
            ),
            Divider(),
            Text(
              "Data Creació: ${strDataCreacio ?? "No assignada"}",
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "ID: $key",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}