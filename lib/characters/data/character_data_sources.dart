import 'package:dio/dio.dart';
import 'package:rick_and_morty_wiki/characters/data/models/character_models.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseModel> getCharacters({int page = 1});
  Future<CharacterModel> getCharacterById(int id);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<CharacterResponseModel> getCharacters({int page = 1}) async {
    final response = await client.get('character?page=$page');
    return CharacterResponseModel.fromJson(response.data);
  }
 
 @override
  Future<CharacterModel> getCharacterById(int id) async {
  final response = await client.get('character/$id');
  return CharacterModel.fromJson(response.data);
}

}
