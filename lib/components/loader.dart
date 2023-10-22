import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui' as ui;

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      color: Colors.transparent, // need to disable click on background
      child: Center(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: LoadingAnimationWidget.waveDots(
              color: Colors.grey,
              size: MediaQuery.of(context).size.height * 0.05),
        ),
      ),
    );
  }
}
