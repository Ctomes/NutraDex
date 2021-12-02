// To parse this JSON data, do
//
//     final foodList = foodListFromJson(jsonString);

import 'dart:convert';

FoodList foodListFromJson(String str) => FoodList.fromJson(json.decode(str));

String foodListToJson(FoodList data) => json.encode(data.toJson());

class FoodList {
  FoodList({
     this.totalHits,
     this.currentPage,
     this.totalPages,
     this.pageList,
     this.foodSearchCriteria,
     this.foods,
     this.aggregations,
  });

  int? totalHits;
  int? currentPage;
  int? totalPages;
  List<int>? pageList;
  FoodSearchCriteria? foodSearchCriteria;
  List<Food>? foods;
  Aggregations? aggregations;

  factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
    totalHits: json["totalHits"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    pageList: List<int>.from(json["pageList"].map((x) => x)),
    foodSearchCriteria: FoodSearchCriteria.fromJson(json["foodSearchCriteria"]),
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    aggregations: Aggregations.fromJson(json["aggregations"]),
  );

  Map<String, dynamic> toJson() => {
    "totalHits": totalHits,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "pageList": List<dynamic>.from(pageList!.map((x) => x)),
    "foodSearchCriteria": foodSearchCriteria!.toJson(),
    "foods": List<dynamic>.from(foods!.map((x) => x.toJson())),
    "aggregations": aggregations!.toJson(),
  };
}

class Aggregations {
  Aggregations({
     this.dataType,
     this.nutrients,
  });

  DataType? dataType;
  Nutrients? nutrients;

  factory Aggregations.fromJson(Map<String, dynamic> json) => Aggregations(
    dataType: DataType.fromJson(json["dataType"]),
    nutrients: Nutrients.fromJson(json["nutrients"]),
  );

  Map<String, dynamic> toJson() => {
    "dataType": dataType!.toJson(),
    "nutrients": nutrients!.toJson(),
  };
}

class DataType {
  DataType({
     this.branded,
     this.srLegacy,
     this.surveyFndds,
     this.foundation,
  });

  int? branded;
  int? srLegacy;
  int? surveyFndds;
  int? foundation;

  factory DataType.fromJson(Map<String, dynamic> json) => DataType(
    branded: json["Branded"],
    srLegacy: json["SR Legacy"],
    surveyFndds: json["Survey (FNDDS)"],
    foundation: json["Foundation"],
  );

  Map<String, dynamic> toJson() => {
    "Branded": branded,
    "SR Legacy": srLegacy,
    "Survey (FNDDS)": surveyFndds,
    "Foundation": foundation,
  };
}

class Nutrients {
  Nutrients();

  factory Nutrients.fromJson(Map<String, dynamic> json) => Nutrients(
  );

  Map<String, dynamic> toJson() => {
  };
}

class FoodSearchCriteria {
  FoodSearchCriteria({
     this.dataType,
     this.query,
     this.generalSearchInput,
     this.pageNumber,
     this.numberOfResultsPerPage,
     this.pageSize,
     this.requireAllWords,
     this.foodTypes,
  });

  List<Type>? dataType;
  String? query;
  String? generalSearchInput;
  int? pageNumber;
  int? numberOfResultsPerPage;
  int? pageSize;
  bool? requireAllWords;
  List<Type>? foodTypes;

  factory FoodSearchCriteria.fromJson(Map<String, dynamic> json) => FoodSearchCriteria(
    dataType: List<Type>.from(json["dataType"].map((x) => typeValues.map[x])),
    query: json["query"],
    generalSearchInput: json["generalSearchInput"],
    pageNumber: json["pageNumber"],
    numberOfResultsPerPage: json["numberOfResultsPerPage"],
    pageSize: json["pageSize"],
    requireAllWords: json["requireAllWords"],
    foodTypes: List<Type>.from(json["foodTypes"].map((x) => typeValues.map[x])),
  );

  Map<String, dynamic> toJson() => {
    "dataType": List<dynamic>.from(dataType!.map((x) => typeValues.reverse[x])),
    "query": query,
    "generalSearchInput": generalSearchInput,
    "pageNumber": pageNumber,
    "numberOfResultsPerPage": numberOfResultsPerPage,
    "pageSize": pageSize,
    "requireAllWords": requireAllWords,
    "foodTypes": List<dynamic>.from(foodTypes!.map((x) => typeValues.reverse[x])),
  };
}

enum Type { SR_LEGACY }

final typeValues = EnumValues({
  "SR Legacy": Type.SR_LEGACY
});

class Food {
  Food({
     this.fdcId,
     this.description,
     this.lowercaseDescription,
     this.commonNames,
     this.additionalDescriptions,
     this.dataType,
     this.ndbNumber,
     this.publishedDate,
     this.foodCategory,
     this.allHighlightFields,
     this.score,
     this.foodNutrients,
     this.scientificName,
  });

  int? fdcId;
  String? description;
  String? lowercaseDescription;
  String? commonNames;
  String? additionalDescriptions;
  Type? dataType;
  int? ndbNumber;
  DateTime? publishedDate;
  FoodCategory? foodCategory;
  String? allHighlightFields;
  double? score;
  List<FoodNutrient>? foodNutrients;
  String? scientificName;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    fdcId: json["fdcId"],
    description: json["description"],
    lowercaseDescription: json["lowercaseDescription"],
    commonNames: json["commonNames"],
    additionalDescriptions: json["additionalDescriptions"],
    dataType: typeValues.map[json["dataType"]],
    ndbNumber: json["ndbNumber"],
    publishedDate: DateTime.parse(json["publishedDate"]),
    foodCategory: foodCategoryValues.map[json["foodCategory"]],
    allHighlightFields: json["allHighlightFields"],
    score: json["score"].toDouble(),
    foodNutrients: List<FoodNutrient>.from(json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
    scientificName: json["scientificName"] == null ? null : json["scientificName"],
  );

  Map<String, dynamic> toJson() => {
    "fdcId": fdcId,
    "description": description,
    "lowercaseDescription": lowercaseDescription,
    "commonNames": commonNames,
    "additionalDescriptions": additionalDescriptions,
    "dataType": typeValues.reverse[dataType],
    "ndbNumber": ndbNumber,
    "publishedDate": "${publishedDate!.year.toString().padLeft(4, '0')}-${publishedDate!.month.toString().padLeft(2, '0')}-${publishedDate!.day.toString().padLeft(2, '0')}",
    "foodCategory": foodCategoryValues.reverse[foodCategory],
    "allHighlightFields": allHighlightFields,
    "score": score,
    "foodNutrients": List<dynamic>.from(foodNutrients!.map((x) => x.toJson())),
    "scientificName": scientificName == null ? null : scientificName,
  };
}

enum FoodCategory { BAKED_PRODUCTS, BABY_FOODS, SWEETS, FRUITS_AND_FRUIT_JUICES, BEVERAGES }

final foodCategoryValues = EnumValues({
  "Baby Foods": FoodCategory.BABY_FOODS,
  "Baked Products": FoodCategory.BAKED_PRODUCTS,
  "Beverages": FoodCategory.BEVERAGES,
  "Fruits and Fruit Juices": FoodCategory.FRUITS_AND_FRUIT_JUICES,
  "Sweets": FoodCategory.SWEETS
});

class FoodNutrient {
  FoodNutrient({
     this.nutrientId,
     this.nutrientName,
     this.nutrientNumber,
     this.unitName,
     this.value,
     this.derivationCode,
     this.derivationDescription,
  });

  int? nutrientId;
  String? nutrientName;
  String? nutrientNumber;
  UnitName? unitName;
  double? value;
  DerivationCode? derivationCode;
  String? derivationDescription;

  factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
    nutrientId: json["nutrientId"],
    nutrientName: json["nutrientName"],
    nutrientNumber: json["nutrientNumber"],
    unitName: unitNameValues.map[json["unitName"]],
    value: json["value"].toDouble(),
    derivationCode: json["derivationCode"] == null ? null : derivationCodeValues.map[json["derivationCode"]],
    derivationDescription: json["derivationDescription"] == null ? null : json["derivationDescription"],
  );

  Map<String, dynamic> toJson() => {
    "nutrientId": nutrientId,
    "nutrientName": nutrientName,
    "nutrientNumber": nutrientNumber,
    "unitName": unitNameValues.reverse[unitName],
    "value": value,
    "derivationCode": derivationCode == null ? null : derivationCodeValues.reverse[derivationCode],
    "derivationDescription": derivationDescription == null ? null : derivationDescription,
  };
}

enum DerivationCode { NC, FLA, Z, NR, FLC, T, BFSN, BNA, A, LC, BFZN, MA, MC, O, BFPN, BFFN, FLM, CAZN, AI, RK, RC, ML }

final derivationCodeValues = EnumValues({
  "A": DerivationCode.A,
  "AI": DerivationCode.AI,
  "BFFN": DerivationCode.BFFN,
  "BFPN": DerivationCode.BFPN,
  "BFSN": DerivationCode.BFSN,
  "BFZN": DerivationCode.BFZN,
  "BNA": DerivationCode.BNA,
  "CAZN": DerivationCode.CAZN,
  "FLA": DerivationCode.FLA,
  "FLC": DerivationCode.FLC,
  "FLM": DerivationCode.FLM,
  "LC": DerivationCode.LC,
  "MA": DerivationCode.MA,
  "MC": DerivationCode.MC,
  "ML": DerivationCode.ML,
  "NC": DerivationCode.NC,
  "NR": DerivationCode.NR,
  "O": DerivationCode.O,
  "RC": DerivationCode.RC,
  "RK": DerivationCode.RK,
  "T": DerivationCode.T,
  "Z": DerivationCode.Z
});

enum UnitName { K_J, UG, G, KCAL, MG, IU }

final unitNameValues = EnumValues({
  "G": UnitName.G,
  "IU": UnitName.IU,
  "KCAL": UnitName.KCAL,
  "kJ": UnitName.K_J,
  "MG": UnitName.MG,
  "UG": UnitName.UG
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

   EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
