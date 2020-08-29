import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading(this.msg);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Llista de la compra"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  msg,
                  style: TextStyle(fontSize: 1000),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}