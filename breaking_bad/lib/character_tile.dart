import 'package:flutter/material.dart';
import 'models.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(character.img), fit: BoxFit.cover)),
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          character.name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ));
  }
}
