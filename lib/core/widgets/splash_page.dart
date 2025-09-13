import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty_wiki/characters/presentation/controllers/character_controllers.dart';
import 'package:rick_and_morty_wiki/characters/presentation/pages/characters_list_page.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'package:rick_and_morty_wiki/core/theme/color_theme.dart';

class SplashController {
  final CharacterController characterController;
  SplashController(this.characterController);

  Future<void> loadData() async {
    await characterController.loadCharacters();
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController(sl<CharacterController>());

  @override
  void initState() {
    super.initState();
    controller.loadData().then((_) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CharactersListPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SvgPicture.asset('assets/rick_and_morty_logo.svg'),
        ),
      ),
    );
  }
}
