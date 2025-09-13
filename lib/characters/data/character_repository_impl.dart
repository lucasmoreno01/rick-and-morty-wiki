import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_repository.dart';
import 'package:rick_and_morty_wiki/characters/data/character_data_sources.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 1}) async {
    final response = await remoteDataSource.getCharacters(page: page);
    return response.results; 
  }
  
 @override
Future<CharacterEntity> getCharacterById(int id) async {
  final response = await remoteDataSource.getCharacterById(id);
  return response; 
}

}
