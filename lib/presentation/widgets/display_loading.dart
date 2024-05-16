import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget customLoading() {
  return const Center(
    child: SpinKitWaveSpinner(
      color: Colors.redAccent,
      size: 50,
    ),
  );
}
