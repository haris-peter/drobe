import 'package:flutter/material.dart';
import 'package:drobe/models/item_model.dart';

class FullImageScreen extends StatelessWidget {
  final Item item;

  const FullImageScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: item.id ?? 'imageHero',
            child: Image.network(item.image ?? ''),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
