import 'dart:convert';
import 'package:flutter/material.dart';

class Item {
  int? id;
  String? image;
  String? name;
  String? color;
  String? category;
  int? dateAdded;

  // Define an Image widget property
  Image? _imageWidget;

  Item({
    this.id,
    this.image,
    this.name,
    this.color,
    this.category,
    this.dateAdded,
  }) {
    // Initialize the Image widget when creating the item
    _imageWidget = Image.memory(
      base64Decode(image ?? ''),
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }

  // Provide a getter for the Image widget
  Image? get imageWidget => _imageWidget;

  // Provide a setter for the Image widget
  set imageWidget(Image? image) {
    _imageWidget = image;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'color': color,
      'category': category,
      'dateAdded': dateAdded,
    };
  }

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int?,
        image = map['image'] as String?,
        name = map['name'] as String?,
        color = map['color'] as String?,
        category = map['category'] as String?,
        dateAdded = map['dateAdded'] as int?,
        _imageWidget = Image.memory(
          base64Decode(map['image'] as String? ?? ''),
          fit: BoxFit.cover,
          gaplessPlayback: true,
        );

  bool contains(String str) {
    return name?.toLowerCase().contains(str.toLowerCase()) == true ||
        color?.toLowerCase().contains(str.toLowerCase()) == true ||
        category?.toLowerCase().contains(str.toLowerCase()) == true;
  }
}
