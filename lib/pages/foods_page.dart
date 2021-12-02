import 'package:flutter/cupertino.dart';
import 'package:testing/pages/search_page.dart';
import 'package:testing/utils/bar_chart.dart';
import 'package:testing/db/database_helper.dart';
import 'package:flutter/material.dart';
import 'delete_card.dart';
import 'detail_page.dart';



class FoodsPage extends StatefulWidget {
  @override
  _FoodsPageState createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  late FoodListChart someChart;
  late List<BarChartModel> barchart;
  late List<LocalFood> foods;
  LocalFood? totalFood;
  bool isLoading = false;
  LocalFood food = LocalFood(
      columnId: 0,
      columnName: '',
      water: 0,
      protein: 0,
      fat: 0,
      carbohydrate: 0,
      sugar: 0,
      sodium: 0,
      page: 1,
      amount: 0,
      unit: ''
  );

  @override
  void initState() {
    refreshFoods();
    if(totalFood != null){
      barchart = getData(totalFood!);
    }else{
      barchart = getData(food);
    }
    super.initState();
    setState(() {});
  }

  void dispose() {
    LocalDatabase.instance.close();
    super.dispose();
  }

  Future refreshFoods() async {
    setState(() => isLoading = true);
    this.foods = await LocalDatabase.instance.readAllFood();
    setState(() {});
    setState(() => isLoading = false);
  }

  LocalFood? findTotalNutrients() {

    double carbohydrates = 0.0;
    double protein = 0.0;
    double fat = 0.0;
    double sugar = 0.0;
    double sodium = 0.0;
    double water = 0.0;
    for(int i= 0; i < foods.length; ++i){
      carbohydrates += foods[i].carbohydrate*foods[i].amount;
      protein += foods[i].protein*foods[i].amount;
      fat += foods[i].fat*foods[i].amount;
      sugar += foods[i].sugar*foods[i].amount;
      sodium += foods[i].sodium*foods[i].amount;
      water += foods[i].water*foods[i].amount;
    }
    totalFood = LocalFood(columnName: 'Total', sodium: sodium,protein: protein, carbohydrate: carbohydrates, fat: fat, sugar: sugar, water: water,page: 0,unit: 'g', amount: 1, columnId: -1);

    return totalFood;
  }

  void moveToSearchPage() async {

    final food = await Navigator.push(
      context,
      CupertinoPageRoute(fullscreenDialog: true, builder: (context) => SearchPage()));

    refreshFoods();
    getData(food);
    findTotalNutrients();

  }
  void moveToDetailCard(var foodId, var num) async {
    final food = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => DetailCard(foodId, num)),
    );
    setState(() {
      refreshFoods();
      totalFood = findTotalNutrients();
      barchart = getData(totalFood!);
      someChart = FoodListChart(data: barchart);
    });

  }
  void bringUpDeleteCard(var foodId) async {
    final food = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => DeleteCard(foodId)),
    );
    setState(() {
      refreshFoods();
      totalFood = findTotalNutrients();
      barchart = getData(totalFood!);
      someChart = FoodListChart(data: barchart);
    });

  }
  @override
  Widget build(BuildContext context) {
    LocalFood _food = LocalFood(
        columnId: 0,
        columnName: '',
        water: 0,
        protein: 0,
        fat: 0,
        carbohydrate: 0,
        sugar: 0,
        sodium: 0,
        page: 1,
        amount: 0,
        unit: ''
    );
    if(!isLoading){
      this.totalFood = findTotalNutrients();
      this.barchart = getData(totalFood!);
      someChart = FoodListChart(data: barchart);
      setState(() {
      });
    }else{
      someChart = FoodListChart(data: barchart);
      setState(() {
      });
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

          ),
          body: Container(
            //valueListenable: number,
              child: Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : foods.isEmpty ? Column(
                    children: [
                      Expanded(
                        flex: 90,
                        child: Center(
                          child: Text(
                            'Your Food List is empty',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ), Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(Icons.analytics_outlined, color: Colors.white,),


                            ),
                            Expanded(
                              child: IconButton(onPressed: () async {
                               // int i = await LocalDatabase.instance.insert(food);
                               // print('Successfully inserted id: + $i');
                              moveToSearchPage();
                              }, icon: Icon(Icons.add, color: Colors.black26,),

                              ),
                            ),
                          ],
                        ),

                      )
                    ],
                  )
                      :       Column(
                    children: [
                      Expanded(
                        flex: 40,
                        child: Container(
                            child: Column(
                              children: [
                                Text(
                                    'Total Nutrients',
                                    style: TextStyle(
                                        color: Colors.white
                                    )
                                ),
                                Expanded(
                                  child: someChart
                                ),
                              ],
                            )
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          physics: BouncingScrollPhysics(),
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            final food = foods[index];

                            return InkWell(
                                onTap:() async {
                                  moveToDetailCard(food.columnId, food.amount);
                                },
                                onLongPress:() async{
                                  bringUpDeleteCard(food.columnId);

                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${food.columnName}',
                                            style: TextStyle(
                                              color: Colors.white, fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                          SizedBox(
                                            height: 80,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 1,
                                              itemBuilder: (_, i) {
                                                return Row(
                                                  children: [
                                                    _buildNutrientBox('Carbs', food.carbohydrate, food.amount, 'g', const Color(0xffD88C9A)),
                                                    _buildNutrientBox('Protein', food.protein, food.amount, 'g', const Color(0xFFF2D0A9)),
                                                    _buildNutrientBox('Total Fat', food.fat, food.amount, 'g', const Color(0xFFF1E3D3)),
                                                    _buildNutrientBox('Sugar', food.sugar, food.amount, 'g', const Color(0xFF99C1B9)),
                                                    _buildNutrientBox('Sodium', food.sodium, food.amount, 'mg', const Color(0xFF8E7DBE)),

                                                    _buildNutrientBox('Water', food.water, food.amount, 'g', const Color(0xFFBBE5ED))
                                                  ],
                                                );
                                              },
                                            ),
                                          ),


                                    ],
                                  ),
                                ),
                            );
                          },

                        ),
                      ),
                      Row(
                          children: [
                            Expanded(
                              child: Icon(Icons.analytics_outlined, color: Colors.white,),
                            ),
                            Expanded(
                              child: IconButton(onPressed: () async {
                                moveToSearchPage();
                              }, icon: Icon(Icons.search, color: Colors.black26,),
                              ),
                            ),
                          ],
                        ),
                    ],
                  )
              )
          )
      ),
    );
  }

  Widget _buildNutrientBox(String nutrient, double amount, int num, String unit, Color color){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$nutrient',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
              Text(
                '${double.parse((amount*num).toStringAsFixed(3))}$unit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
