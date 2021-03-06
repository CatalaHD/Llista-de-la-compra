import 'package:flutter/material.dart';
import 'package:totfet/models/Prioritat.dart';
import 'package:totfet/models/Report.dart';
import 'package:totfet/models/Tipus_report.dart';
import 'package:totfet/services/auth.dart';

class ReportBug extends StatefulWidget {
  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  final _formKey = GlobalKey<FormState>();

  Report report = Report.perDefecte(AuthService().userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Informa d'un error"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[400],
                Colors.blue[900],
              ],
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => report.titol == null || report.titol == ""
            ? true
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Tens canvis sense guardar!"),
                  content: Text("Vols sortir sense guardar?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel·lar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text("Sortir"),
                    ),
                  ],
                ),
              ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      value = value.trim();
                      if (value == "") {
                        return "Siusplau, posa un titol";
                      } else if (value.length > 50) {
                        return "Titol massa llarg (max. 50 caràcters)";
                      }
                      return null;
                    },
                    initialValue: report.titol,
                    onChanged: (str) {
                      setState(() {
                        report.titol = (str.trim() == "") ? null : str.trim();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Titol de l'informe*",
                      helperText: '*Requerit',
                      counterText: "${report.titol?.length ?? 0}/50",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      value = value.trim();
                      if (value == "") {
                        return "Siusplau, posa una descripció";
                      } else if (value.length > 255) {
                        return "Descripció massa llarga (max. 255 caràcters)";
                      }
                      return null;
                    },
                    initialValue: report.descripcio,
                    onChanged: (str) {
                      setState(() {
                        report.descripcio =
                            (str.trim() == "") ? null : str.trim();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Descripció de l'informe*",
                      helperText: '*Requerit',
                      counterText: "${report.descripcio?.length ?? 0}/255",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text("Selecciona un tipus de l'informe"),
                      DropdownButton<TipusReport>(
                        hint: Text("Escolleix un tipus"),
                        value: report.tipus,
                        items: TipusReport.values
                            .map<DropdownMenuItem<TipusReport>>(
                                (TipusReport value) {
                          return DropdownMenuItem<TipusReport>(
                            value: value,
                            child: Row(
                              children: [
                                tipusReportIcon(value),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(tipusReportToString(value)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (TipusReport newValue) {
                          setState(() {
                            report.tipus = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text("Selecciona una prioritat"),
                      DropdownButton<Prioritat>(
                        hint: Text("Escolleix una prioritat"),
                        value: report.prioritat,
                        items: Prioritat.values
                            .map<DropdownMenuItem<Prioritat>>(
                                (Prioritat value) {
                          return DropdownMenuItem<Prioritat>(
                            value: value,
                            child: Row(
                              children: [
                                prioritatIcon(value),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(prioritatToString(value)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Prioritat newValue) {
                          setState(() {
                            report.prioritat = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context, report);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.send,
                        size: 40,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
