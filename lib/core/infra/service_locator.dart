import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:rick_and_morty_wiki/characters/data/character_data_sources.dart';
import 'package:rick_and_morty_wiki/characters/data/character_repository_impl.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_repository.dart';
import 'package:rick_and_morty_wiki/characters/domain/characters_use_cases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: 'https://rickandmortyapi.com/api/',
    connectTimeout: Duration(milliseconds: 5000),
    receiveTimeout: Duration(milliseconds: 3000),
  )));

  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetCharacters(sl()));
  sl.registerLazySingleton(() => GetCharacterDetails(sl()));
}
