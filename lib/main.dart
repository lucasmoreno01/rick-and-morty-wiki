import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:rick_and_morty_wiki/core/infra/query_client.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'characters/presentation/pages/characters_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(QueryClientProvider(queryClient: queryClient, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty Wiki',
      home: const CharacterListPage(),
    );
  }
}
