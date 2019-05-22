import 'package:flutter/material.dart';
import 'package:flutter_fab_loader/fab_loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FabLoader Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('FabLoader Flutter Demo'),
          ),
          body: Center(
            child: Text('Empty state ¯\\_(ツ)_/¯'),
          ),
          floatingActionButton: FabLoader(
            child: FloatingActionButton(
              onPressed: _fabPressed,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        ));
  }
}

void _fabPressed() {}
