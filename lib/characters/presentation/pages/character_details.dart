import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({super.key});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page works',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
