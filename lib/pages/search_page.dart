import 'package:flutter/material.dart';
import 'package:testing/db/database_helper.dart';
import 'package:testing/pages/detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:testing/utils/widget_functions.dart';
import 'dart:convert' as convert;
import '../api/completeFoodList.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController eCtrl = new TextEditingController();
  List<Food> foodResults = [];
  String value= '';

  bool loading = true;
  int num = 0;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    LocalFood food = LocalFood(
        columnId: 31,
        columnName: ' Green Apple',
        water: 11.2,
        protein: 30.1,
        fat:12.0,
        carbohydrate: 0.0,
        sugar: 10.0,
        sodium: 10.1,
        page: 1,
        amount: 5,
        unit: ''
    );
    return SafeArea(
      child: Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(

            child: Column(
              children: [
                  addVerticalSpace(padding+20),
                Padding(

                      padding: sidePadding,
                      child: new TextField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        controller: eCtrl,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            )
                          ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide
                          (
                            width: 2.0,
                            color: Colors.white,
                          ),
                        ),
                            labelText: 'Search Food Items',
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),

                        ),
                        onSubmitted: (text) {
                          try{
                            assembleList(text);
                          }catch(e){
                            print(e);
                          }
                          eCtrl.clear();
                          setState(() {});
                        },
                      ),
                    ),
                new Expanded(
                  flex: 80,
                    child: Padding(
                      padding: sidePadding,
                      child: new ListView.builder
                        (

                          physics: BouncingScrollPhysics(),
                          itemCount: foodResults.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return new InkWell(

                                onTap:(){
                                  Navigator.push(
                                    context,
                                   //MaterialPageRoute(builder: (context) => DetailScreen(foodResults[index].fdcId == null ? 0 : foodResults[index].fdcId as int)),
                                    MaterialPageRoute(builder: (context) => DetailCard(foodResults[index].fdcId == null ? 0 : foodResults[index].fdcId as int, 1)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(foodResults[index].description as String,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  ),
                                ));

                          }
                      ),
                    )
                ),


                    Row(
                    children: [
                      Expanded(
                      child: IconButton(onPressed: () async {
                        setState(() {});
                        Navigator.pop(context, food);
                        }, icon: Icon(Icons.analytics_outlined, color: Colors.black26,),

                      ),
                      ),
                      Expanded(
                        child: Icon(Icons.search, color: Colors.white,),

                      ),
                    ],


                )
              ],

            )
        ),
      ),
    );
  }//var url = Uri.parse("https://api.nal.usda.gov/fdc/v1/foods/search?api_key=40zJtqYv62tgSLd2CmPYeUwqngckPaEO0HLC5pcn&query=$name&dataType=SR%20Legacy&pageNumber=1");
  Future<void> assembleList(String name) async {
    var url = Uri.parse("https://api.nal.usda.gov/fdc/v1/foods/search?api_key=40zJtqYv62tgSLd2CmPYeUwqngckPaEO0HLC5pcn&query=$name&dataType=SR%20Legacy&pageNumber=1");
    var response = await http.get(url);

    if (response.statusCode == 200){
      String data = response.body;
      final parsedJson = convert.jsonDecode(data);
      final searchedList = FoodList.fromJson(parsedJson);
      foodResults = searchedList.foods!;
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}

/*
          TextButton(
            onPressed: () async {
              int i = await LocalDatabase.instance.insert(food);
              print('Successfully inserted id: + $i');
              setState(() {});

              Navigator.pop(context, food);
            },
            child: const Text(
                'Go Back'
            ),
 */