import 'package:algotest2/shared/shared_methods.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_facebook_callback/share_facebook_callback.dart';

class SharePage extends StatefulWidget {
  final Widget imageMeme;
  const SharePage({super.key, required this.imageMeme});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final GlobalKey memeGlobalKey = GlobalKey();
  final _shareFacebookCallbackPlugin = ShareFacebookCallback();

  @override
  void initState() {
    super.initState();
  }

  void shareMemeToFacebook() async {
    Uint8List jpgBytes = await captureWidget(memeGlobalKey);

    try {
      await _shareFacebookCallbackPlugin.shareFacebook(
          type: ShareType.sharePhotoFacebook,
          uint8Image: jpgBytes,
          quote: 'Hello World');
    } catch (e) {
      print('Gagal membagikan meme ke facebook : $e');
    }
  }

  void shareMemeToTwitter() async {
    Uint8List jpgBytes = await captureWidget(memeGlobalKey);

    try {
      await Share.files(
        'MimGenerator',
        {
          'MimGenerator.png': jpgBytes.buffer.asUint8List(),
        },
        {'image/png'},
      );
    } catch (e) {
      print('Gagal membagikan meme ke social media : $e');
    }
  }

  Container body() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: memeGlobalKey,
            child: widget.imageMeme,
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => shareMemeToFacebook(),
                  child: const Text('Share to FB'),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => shareMemeToTwitter(),
                  child: const Text('Share to Twitter'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MimGenerator'),
      ),
      body: body(),
    );
  }
}
