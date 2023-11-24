import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts; // or 'package:charts_flutter/flutter.dart' for the latest version
import 'package:drobe/models/color_data_model.dart';
import 'package:drobe/models/item_model.dart';

class ColorChart extends StatefulWidget {
  final List<Item>? items;

  ColorChart({Key? key, this.items}) : super(key: key);

  @override
  _ColorChartState createState() => _ColorChartState();
}

class _ColorChartState extends State<ColorChart> {
  List<ColorData> colorData = [];

  @override
  void initState() {
    super.initState();
    _initializeColorData();
  }

  void _initializeColorData() {
    widget.items?.forEach((item) {
      String? itemColor = item.color?.toLowerCase();

      if (itemColor != null) {
        bool colorLogged = colorData.any((element) => element.color == itemColor);

        if (colorLogged) {
          colorData.firstWhere((element) => element.color == itemColor).increment();
        } else {
          switch (itemColor) {
            case "black":
              colorData.add(ColorData(itemColor, 1, Colors.black));
              break;
            case "grey":
              colorData.add(ColorData(itemColor, 1, Colors.grey));
              break;
            case "white":
              colorData.add(ColorData(itemColor, 1, Colors.white));
              break;
            case "navy":
              colorData.add(ColorData(itemColor, 1, Colors.blue[900]!));
              break;
            case "blue":
              colorData.add(ColorData(itemColor, 1, Colors.blue[200]!));
              break;
            case "maroon":
              colorData.add(ColorData(itemColor, 1, Colors.red[900]!));
              break;
          }
        }
      }
    });
  }

  @override
 Widget build(BuildContext context) {
  var series = [
    charts.Series<ColorData, String>(
      id: 'Colors',
      domainFn: (ColorData data, _) => data.color,
      measureFn: (ColorData data, _) => data.count,
      colorFn: (ColorData data, _) => charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
      data: colorData,
    ),
  ];

  Widget chart = charts.PieChart(
    series,
    animate: true,
  );

  return chart;
}

}
