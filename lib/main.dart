import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_wiki/characters/presentation/pages/character_details.dart';
import 'package:rick_and_morty_wiki/characters/presentation/pages/characters_list_page.dart';
import 'package:rick_and_morty_wiki/core/app_routes.dart';
import 'package:rick_and_morty_wiki/core/infra/query_client.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'package:rick_and_morty_wiki/core/widgets/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts([GoogleFonts.nunito()]);
  await init();
  runApp(
    QueryClientProvider(
      queryClient: queryClient,
      child: const RickAndMortyWiki(),
    ),
  );
}

class RickAndMortyWiki extends StatelessWidget {
  const RickAndMortyWiki({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        AppRoutes.charactersList: (_) => const CharactersListPage(),
        AppRoutes.characterDetails: (_) => const CharacterDetails(),
      },
      title: 'Rick and Morty Wiki',
    );
  }
}
