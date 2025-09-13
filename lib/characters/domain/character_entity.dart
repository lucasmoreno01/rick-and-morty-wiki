class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocationEntity origin;
  final CharacterLocationEntity location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
}

class CharacterLocationEntity {
  final String name;
  final String url;

  CharacterLocationEntity({required this.name, required this.url});
}

class ResponseInfoEntity {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  ResponseInfoEntity({required this.count, required this.pages, this.next, this.prev});

 
}

class CharacterResponseEntity {
  final ResponseInfoEntity info;
  final List<CharacterEntity> results;

  CharacterResponseEntity({required this.info, required this.results});
}
