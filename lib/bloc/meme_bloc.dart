import 'package:algotest2/models/meme_models.dart';
import 'package:algotest2/services/meme_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  final MemeServices memeServices;
  MemeBloc({required this.memeServices}) : super(MemeInitial()) {
    on<FetchMemes>((event, emit) async {
      List<Meme> memes = await memeServices.getMemes();

      emit(MemeInitial());

      emit(MemeLoaded(memes: memes));
    });
  }
}
