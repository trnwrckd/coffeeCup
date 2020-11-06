// LOADING WIDGET
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[400],
      child: SpinKitCubeGrid(
        color: Colors.brown,
        size: 50,
      ),
    );
  }
}
