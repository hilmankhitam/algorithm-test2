import 'dart:io';

import 'package:algotest2/pages/share_page.dart';
import 'package:algotest2/shared/shared_methods.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SavePage extends StatefulWidget {
  final Widget widgetMeme;
  final String logoPath;
  final String text;
  const SavePage({
    super.key,
    required this.widgetMeme,
    required this.logoPath,
    required this.text,
  });

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final GlobalKey memeGlobalKey = GlobalKey();

  void saveToLocal() async {
    if (await Permission.storage.request().isGranted) {
      var jpgBytes = await captureWidget(memeGlobalKey);
      var nameFile =
          '/storage/emulated/0/Download/${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().second}.jpg';

      await File(nameFile).writeAsBytes(jpgBytes);
    }
  }

  ListView body(BuildContext context) {
    return ListView(
      children: [
        RepaintBoundary(
          key: memeGlobalKey,
          child: imageMeme(context),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async => saveToLocal(),
                  child: const Text('Simpan'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SharePage(
                          imageMeme: imageMeme(context),
                        ),
                      ),
                    );
                  },
                  child: const Text('Share'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MimGenerator'),
      ),
      body: body(context),
    );
  }

  Stack imageMeme(BuildContext context) {
    return Stack(
      children: [
        widget.widgetMeme,
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(widget.logoPath),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
