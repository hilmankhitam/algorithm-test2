import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Future<Uint8List> captureWidget(GlobalKey globalKey) async {
  final RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

  final ui.Image image = await boundary.toImage();

  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

  final Uint8List jpgBytes = byteData!.buffer.asUint8List();

  return jpgBytes;
}
