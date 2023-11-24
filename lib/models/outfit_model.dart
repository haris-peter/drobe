class Outfit {
  int? id;
  String? name;
  String? category;
  List<int>? itemsInOutfit;
  int? dateAdded;
  List<bool>? seasons;
  List<String> seasonNames = [];

  Outfit({
    this.id,
    this.name,
    this.category,
    this.itemsInOutfit,
    this.dateAdded,
    this.seasons,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'dateAdded': dateAdded,
      'summer': boolToInt(seasons?[0]),
      'spring': boolToInt(seasons?[1]),
      'fall': boolToInt(seasons?[2]),
      'winter': boolToInt(seasons?[3]),
    };
  }

  Outfit.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int?;
    name = map['name'] as String?;
    category = map['category'] as String?;
    dateAdded = map['dateAdded'] as int?;
    seasons = [
      intToBool(map['summer']),
      intToBool(map['spring']),
      intToBool(map['fall']),
      intToBool(map['winter']),
    ];
    for (int i = 0; i < seasons!.length; i++) {
      if (seasons![i]) {
        seasonNames.add(_seasonName(i));
      }
    }
  }

  String _seasonName(int index) {
    switch (index) {
      case 0:
        return 'Summer';
      case 1:
        return 'Spring';
      case 2:
        return 'Fall';
      case 3:
        return 'Winter';
      default:
        return '';
    }
  }

  int boolToInt(bool? b) {
    return b == true ? 1 : 0;
  }

  bool intToBool(int? x) {
    return x == 1;
  }

  bool contains(String str) {
    return name?.toLowerCase().contains(str.toLowerCase()) == true ||
        category?.toLowerCase().contains(str.toLowerCase()) == true;
  }

  @override
  String toString() {
    return '$id $name $category $itemsInOutfit';
  }
}
