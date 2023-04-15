import 'package:algotest2/bloc/meme_bloc.dart';
import 'package:algotest2/services/meme_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => MemeBloc(
      memeServices: locator(),
    ),
  );

  //services
  locator.registerLazySingleton<MemeServices>(() => MemeServices());
}
