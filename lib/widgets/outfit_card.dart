import 'package:flutter/material.dart';
import 'package:drobe/models/item_model.dart';
import 'package:drobe/models/outfit_model.dart';

class OutfitCard extends StatelessWidget {
  final List<Item>? itemsInOutfit;
  final Outfit? outfit;

  const OutfitCard({Key? key, this.itemsInOutfit, this.outfit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return outfit != null
        ? Hero(
            tag: outfit!.id ?? UniqueKey(),
            child: Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.0),
              child: buildOutfitCard(),
            ),
          )
        : buildOutfitCard();
  }

  AspectRatio buildOutfitCard() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.grey[100],
                margin: EdgeInsets.all(4.0),
                child: buildItemIcons(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridView buildItemIcons() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: EdgeInsets.all(4.0),
      itemCount: itemsInOutfit?.length.clamp(0, 4),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: itemsInOutfit?[index].imageWidget,
          ),
        );
      },
    );
  }
}
