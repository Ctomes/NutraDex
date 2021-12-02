

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:testing/db/database_helper.dart';
class BarChartModel{
  String nutrient;
  double amount;
  final charts.Color color;

  BarChartModel({
    required this.nutrient,
    required this.amount,
    required this.color
  });
}
List<BarChartModel> getData(LocalFood totalFood){
  return [
    BarChartModel(
        nutrient: 'Carbs',
        amount: totalFood.carbohydrate,
        color: charts.ColorUtil.fromDartColor(Color(0xffD88C9A))
    ),
    BarChartModel(
        nutrient: 'Protein',
        amount: totalFood.protein,
        color: charts.ColorUtil.fromDartColor(Color(0xFFF2D0A9))
    ),
    BarChartModel(
        nutrient: 'Total Fat',
        amount: totalFood.fat,
        color: charts.ColorUtil.fromDartColor(Color(0xFFF1E3D3))
    ),
    BarChartModel(
        nutrient: 'Sugar',
        amount: totalFood.sugar,
        color: charts.ColorUtil.fromDartColor(Color(0xFF99C1B9))
    ),
    BarChartModel(
        nutrient: 'Sodium',
        amount: totalFood.sodium/1000,
        color: charts.ColorUtil.fromDartColor(Color(0xFF8E7DBE))
    ),
    BarChartModel(
        nutrient: 'Water',
        amount: totalFood.water,
        color: charts.ColorUtil.fromDartColor(Color(0xFFBBE5ED))
    ),
  ];
}

class FoodListChart extends StatefulWidget {
  final List<BarChartModel> data;
  const FoodListChart({required this.data,});

  @override
  FoodListChartState createState() => new FoodListChartState(data: data);

}
class FoodListChartState extends State<FoodListChart> {
  List<BarChartModel> data;

  //late final List<BarChartModel> data;
  FoodListChartState({required this.data});

  void incrementState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    incrementState();
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series
        (
        id: 'grams',
        data: data,
        domainFn: (BarChartModel series, _) => series.nutrient,
        measureFn: (BarChartModel series, _) => series.amount,
        colorFn: (BarChartModel series, _) => series.color,

      )
    ];

    return charts.BarChart(series, animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  color: charts.MaterialPalette.white
              )
          )
      ), primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  color: charts.MaterialPalette.white
              )
          )
      ),
    );
  }

}