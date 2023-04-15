part of 'meme_bloc.dart';

abstract class MemeState extends Equatable {
  const MemeState();
}

class MemeInitial extends MemeState {
  @override
  List<Object?> get props => [];
}

class MemeLoaded extends MemeState {
  final List<Meme> memes;

  const MemeLoaded({required this.memes});

  @override
  List<Object?> get props => [memes];
}
