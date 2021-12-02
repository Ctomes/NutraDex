import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:testing/db/database_helper.dart';
import 'package:testing/utils/constants.dart';
import '../api/foodmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetailCard extends StatefulWidget {
  final int id;
  final int numberOfFood;
  DetailCard(this.id, this.numberOfFood);


  @override
  _DetailCardState createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  late FoodData foodData;
  bool loading = true;
  var _currentValue = 1;

  @override
  void initState() {
    _currentValue = widget.numberOfFood;
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    var url =
    Uri.parse("https://api.nal.usda.gov/fdc/v1/food/${widget.id
        .toInt()}?api_key=40zJtqYv62tgSLd2CmPYeUwqngckPaEO0HLC5pcn");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      final parsedJson = convert.jsonDecode(data);
      final searchedFood = FoodData.fromJson(parsedJson);
      foodData = searchedFood;
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    //final ThemeData themeData = Theme.of(context);
    //double padding = 25;
   // final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        body: Container(
          child: loading ? Center(child: CircularProgressIndicator(),)
          : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardTemplate(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState((){
                        final newValue = _currentValue - 1;
                        _currentValue = newValue.clamp(1, 20);
                      }),
                      icon: Icon(
                          Icons.remove,
                          color: Colors.white,

                      ),
                    ),
                    NumberPicker(
                      itemWidth: 60,
                      textStyle: TextStyle(
                        color: Colors.white
                      ),
                      axis: Axis.horizontal,
                      value: _currentValue,
                      minValue: 1,
                      maxValue: 20,
                      onChanged: (value) => setState(()
                      => _currentValue = value,

                      ) ,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: COLOR_BLACK)
                      ),
                    ),
                    IconButton(
                      onPressed:() => setState((){
                        final newValue = _currentValue + 1;
                        _currentValue = newValue.clamp(1, 20);
                      }),
                      icon: Icon(Icons.add, color: Colors.white,),
                    ),
                  ],
                ),
                addToMyList(),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget cardTemplate(info)
  {
    //var nutrientArrLocation = findPosition(0);
    final ThemeData themeData = Theme.of(context);
    return Card(

      shadowColor: Colors.black54,
      elevation: 6,
      color: Colors.blueGrey,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(

        children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Text(
              "${foodData.description}",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
          ),
        ),
         Container(
          child: Text(
            "Portion: per 100g",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
         ),
         Container(

           height: 400,
           child: SizedBox(
             child: ListView.builder(
                 itemCount: foodData.foodNutrients!.length,
                 itemBuilder: (context, index){
               return getTextWidget(index, themeData.textTheme.bodyText1);
             }),
           ),
         ),
          SizedBox(height: 8.0),
      ],
      )
    );
  }

  List<int> findPosition(int index)
  {
    String? nutrient;
    int length = foodData.foodNutrients!.length;
    var nutrientLocationArray = new List.filled(6,-1);

    for(int i = 0; i< length; i++){
      nutrient = foodData.foodNutrients![i].nutrient!.name;
      switch(nutrient){
        case 'Water' : {
          nutrientLocationArray[0]= i;
              break;
        }
        case "Protein" : {
          nutrientLocationArray[1]= i;
          break;
        }
        case "Total lipid (fat)" : {
          nutrientLocationArray[2]= i;
          break;
        }
        case "Carbohydrate, by difference" : {
          nutrientLocationArray[3]= i;
          break;
        }
        case "Sugars, total including NLEA" : {
          nutrientLocationArray[4]= i;
          break;
        }
        case "Sodium, Na" : {
          nutrientLocationArray[5]= i;
          break;
        }
        default : {
          //do nothing
        }
      }

    }
    print(nutrientLocationArray);
    return nutrientLocationArray;
  }
  String enumerateStrings(String? value)
  {
    print(value);
    switch(value) {
      case "UnitName.G": {return "g"; }

      case "UnitName.MG": {return "mg"; }


      case "UnitName.KCAL": {return "kcal"; }


      case "UnitName._G": {return "µg"; }


      default: { return ""; }

    }
  }
Widget getTextWidget(int index, var style){
  return foodData.foodNutrients![index].amount == null
      ? Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 6.0),
        child: Container(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(
            "${foodData.foodNutrients![index].nutrient!.name} ",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold
              ),
        ),]
    ),
  ),
      )
  : Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${foodData.foodNutrients![index].nutrient!.name} ",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
          ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "${foodData.foodNutrients![index].amount} "
                "${enumerateStrings("${foodData.foodNutrients![index].nutrient!.unitName}")}",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget addToMyList() {
    var nutrientArrLocation = findPosition(0);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(COLOR_LIGHTGREY),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 9, vertical: 15),),
                ),
                onPressed: () async {
                  /*print('Successfully deleted id: + ${widget.id}');
                  Navigator.pop(context, await LocalDatabase.instance.delete(widget.id));

                   */
                  setState(() {Navigator.pop(context);});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      'Cancel',
                      style: TextStyle(color: COLOR_WHITE,
                      fontSize: 16),
                    )
                  ],
                )),
          ),
          Container(
            child: SizedBox(
              width: 16,
            ),
          ),
          Container(

            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(COLOR_GREY),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 15),),
                ),
                onPressed:() async {
                  LocalFood food = LocalFood(
                      columnId: widget.id,
                      columnName: "${foodData.description} ",
                      water: nutrientArrLocation[0] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[0]].amount!,
                      protein: nutrientArrLocation[1] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[1]].amount!,
                      fat: nutrientArrLocation[2] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[2]].amount!,
                      carbohydrate: nutrientArrLocation[3] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[3]].amount!,
                      sugar: nutrientArrLocation[4] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[4]].amount!,
                      sodium: nutrientArrLocation[5] == -1 ? 0.0 : foodData.foodNutrients![nutrientArrLocation[5]].amount!,
                      page: 1,
                      amount: _currentValue,
                      unit: ""
                  );
                                    int i = await LocalDatabase.instance.insert(food);
                                    print('Successfully inserted id: + ${widget.id}');
                                    setState(() {});
                  print('Successfully deleted id: + ${widget.id}');
                  //Navigator.pop(context);
                  setState(() {Navigator.pop(context, );});
                                    //  setState((){});

                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      'Confirm',
                      style: TextStyle(color: COLOR_WHITE,
                          fontSize: 16),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
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
