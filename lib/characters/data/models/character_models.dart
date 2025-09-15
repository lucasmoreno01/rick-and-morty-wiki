import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_status.dart';

class CharacterLocationModel extends CharacterLocationEntity {
  CharacterLocationModel({
    required super.name,
    required super.url,
  });

  factory CharacterLocationModel.fromJson(Map<String, dynamic> json) {
    return CharacterLocationModel(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  CharacterLocationEntity toEntity() {
    return CharacterLocationEntity(
      name: name,
      url: url,
    );
  }
}

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: CharacterStatus.values.byName(json['status']),
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: CharacterLocationModel.fromJson(json['origin']),
      location: CharacterLocationModel.fromJson(json['location']),
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin,
      location: location,
      image: image,
      episode: episode,
      url: url,
      created: created,
    );
  }
}

class ResponseInfoModel extends ResponseInfoEntity {
  ResponseInfoModel({
    required super.count,
    required super.pages,
    super.next,
    super.prev,
  });

  factory ResponseInfoModel.fromJson(Map<String, dynamic> json) {
    return ResponseInfoModel(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  ResponseInfoEntity toEntity() {
    return ResponseInfoEntity(
      count: count,
      pages: pages,
      next: next,
      prev: prev,
    );
  }
}

class CharacterResponseModel extends CharacterResponseEntity {
  CharacterResponseModel({
    required super.info,
    required super.results,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: ResponseInfoModel.fromJson(json['info']),
      results: (json['results'] as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList(),
    );
  }

  CharacterResponseEntity toEntity() {
    return CharacterResponseEntity(
      info: info,
      results: results,
    );
  }
}