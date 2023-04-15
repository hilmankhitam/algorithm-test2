import 'dart:io';

import 'package:algotest2/models/meme_models.dart';
import 'package:algotest2/pages/save_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {
  final Meme meme;
  const DetailPage({super.key, required this.meme});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController textController = TextEditingController();
  XFile? logo;

  Future<void> getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        logo = image;
      });
    }
  }

  Widget _displayLogo() {
    if (logo != null) {
      final path = logo!.path;
      return GestureDetector(
        onTap: () => getImage(),
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
              image: FileImage(
                File(path),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => getImage(),
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: const Icon(Icons.browse_gallery),
        ),
      );
    }
  }

  Widget imageMeme() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            widget.meme.url,
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  ListView body(BuildContext context) {
    return ListView(
      children: [
        imageMeme(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Column(
                children: [
                  const Text('Add Logo'),
                  const SizedBox(
                    height: 8,
                  ),
                  _displayLogo(),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextFormField(
                      maxLines: 4,
                      controller: textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Add Text...',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ElevatedButton(
            onPressed: () {
              if (logo != null && textController.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavePage(
                      widgetMeme: imageMeme(),
                      logoPath: logo!.path,
                      text: textController.text,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tambahkan logo dan text')));
              }
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meme.name),
      ),
      body: body(context),
    );
  }
}
