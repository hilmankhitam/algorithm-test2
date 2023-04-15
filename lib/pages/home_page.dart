import 'package:algotest2/bloc/meme_bloc.dart';
import 'package:algotest2/models/meme_models.dart';
import 'package:algotest2/pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> refreshData() async {
    Future.delayed(const Duration(milliseconds: 1500));
    context.read<MemeBloc>().add(FetchMemes());
  }

  ListView body() {
    return ListView(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 80,
          child: Center(
            child: Text(
              'MimGenerator',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BlocBuilder<MemeBloc, MemeState>(
          builder: (context, memeState) {
            if (memeState is MemeLoaded) {
              List<Meme> memes = memeState.memes;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: memes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(meme: memes[index]),
                        ),
                      );
                    },
                    child: Card(
                      child: CachedNetworkImage(
                        imageUrl: memes[index].url,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: Scaffold(
        body: body(),
      ),
    );
  }
}
