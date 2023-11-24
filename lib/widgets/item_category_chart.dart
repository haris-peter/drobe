import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:drobe/models/item_category_data_model.dart';
import 'package:drobe/models/item_model.dart';

class ItemCategoryChart extends StatefulWidget {
  final List<Item>? items;

  ItemCategoryChart({Key? key, this.items}) : super(key: key);

  @override
  _CategoryChart createState() => _CategoryChart();
}

class _CategoryChart extends State<ItemCategoryChart> {
  List<ItemCategoryData> itemCategoryData = [];

  @override
  void didUpdateWidget(covariant ItemCategoryChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle changes to the widget's properties here
    if (widget.items != null) {
      updateChartData();
    }
  }

  void updateChartData() {
  itemCategoryData.clear();

  for (Item item in widget.items!) {
    String? itemCategory = item.category?.toLowerCase();
    if (itemCategory != null) {
      ItemCategoryData? existingCategory = itemCategoryData.firstWhere(
        (element) => element.category == itemCategory,
        
      );

      if (existingCategory != null) {
        existingCategory.increment();
      } else {
        switch (itemCategory) {
          case "tops":
            itemCategoryData.add(ItemCategoryData(itemCategory, 1, Colors.blue[900]!));
            break;
          case "bottoms":
            itemCategoryData.add(ItemCategoryData(itemCategory, 1, Colors.blue[200]!));
            break;
          case "accessories":
            itemCategoryData.add(ItemCategoryData(itemCategory, 1, Colors.grey));
            break;
        }
      }
    }
  }
}


  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series<ItemCategoryData, String>(
        id: 'Item Categories',
        domainFn: (ItemCategoryData data, _) => data.category,
        measureFn: (ItemCategoryData data, _) => data.count,
        colorFn: (ItemCategoryData data, _) => charts.ColorUtil.fromDartColor(Colors.deepPurple),
        data: itemCategoryData,
      ),
    ];

    Widget chart = charts.BarChart(
      series,
      animate: true,
    );

    return chart;
  }
}
