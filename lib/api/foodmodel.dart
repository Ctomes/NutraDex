// To parse this JSON data, do
//
//     final foodData = foodDataFromJson(jsonString);

import 'dart:convert';

FoodData foodDataFromJson(String str) => FoodData.fromJson(json.decode(str));

String foodDataToJson(FoodData data) => json.encode(data.toJson());

class FoodData {
  FoodData({
    this.fdcId,
    this.description,
    this.publicationDate,
    this.foodNutrients,
    this.dataType,
    this.foodClass,
    this.scientificName,
    this.inputFoods,
    this.foodComponents,
    this.foodAttributes,
    this.nutrientConversionFactors,
    this.ndbNumber,
    this.isHistoricalReference,
    this.foodCategory,
  });

  int? fdcId;
  String? description;
  String? publicationDate;
  List<FoodNutrient>? foodNutrients;
  String? dataType;
  String? foodClass;
  String? scientificName;
  List<InputFoodElement>? inputFoods;
  List<dynamic>? foodComponents;
  List<dynamic>? foodAttributes;
  List<NutrientConversionFactor>? nutrientConversionFactors;
  int? ndbNumber;
  bool? isHistoricalReference;
  Food? foodCategory;

  factory FoodData.fromJson(Map<String, dynamic> json) => FoodData(
    fdcId: json["fdcId"],
    description: json["description"],
    publicationDate: json["publicationDate"],
    foodNutrients: List<FoodNutrient>.from(json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
    dataType: json["dataType"],
    foodClass: json["foodClass"],
    scientificName: json["scientificName"],
    inputFoods: List<InputFoodElement>.from(json["inputFoods"].map((x) => InputFoodElement.fromJson(x))),
    foodComponents: List<dynamic>.from(json["foodComponents"].map((x) => x)),
    foodAttributes: List<dynamic>.from(json["foodAttributes"].map((x) => x)),
    nutrientConversionFactors: List<NutrientConversionFactor>.from(json["nutrientConversionFactors"].map((x) => NutrientConversionFactor.fromJson(x))),
    ndbNumber: json["ndbNumber"],
    isHistoricalReference: json["isHistoricalReference"],
    foodCategory: Food.fromJson(json["foodCategory"]),
  );

  Map<String, dynamic> toJson() => {
    "fdcId": fdcId,
    "description": description,
    "publicationDate": publicationDate,
    "foodNutrients": List<dynamic>.from(foodNutrients!.map((x) => x.toJson())),
    "dataType": dataType,
    "foodClass": foodClass,
    "scientificName": scientificName,
    "inputFoods": List<dynamic>.from(inputFoods!.map((x) => x.toJson())),
    "foodComponents": List<dynamic>.from(foodComponents!.map((x) => x)),
    "foodAttributes": List<dynamic>.from(foodAttributes!.map((x) => x)),
    "nutrientConversionFactors": List<dynamic>.from(nutrientConversionFactors!.map((x) => x.toJson())),
    "ndbNumber": ndbNumber,
    "isHistoricalReference": isHistoricalReference,
    "foodCategory": foodCategory!.toJson(),
  };
}

class Food {
  Food({
    this.id,
    this.code,
    this.description,
    this.foodNutrientSource,
  });

  int? id;
  String? code;
  Description? description;
  Food? foodNutrientSource;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["id"],
    code: json["code"],
    description: descriptionValues.map[json["description"]],
    foodNutrientSource: json["foodNutrientSource"] == null ? null : Food.fromJson(json["foodNutrientSource"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": descriptionValues.reverse![description],
    "foodNutrientSource": foodNutrientSource == null ? null : foodNutrientSource!.toJson(),
  };
}

enum Description { FRUITS_AND_FRUIT_JUICES, ANALYTICAL, CALCULATED, SUMMED, ANALYTICAL_OR_DERIVED_FROM_ANALYTICAL, CALCULATED_OR_IMPUTED }

final descriptionValues = EnumValues({
  "Analytical": Description.ANALYTICAL,
  "Analytical or derived from analytical": Description.ANALYTICAL_OR_DERIVED_FROM_ANALYTICAL,
  "Calculated": Description.CALCULATED,
  "Calculated or imputed": Description.CALCULATED_OR_IMPUTED,
  "Fruits and Fruit Juices": Description.FRUITS_AND_FRUIT_JUICES,
  "Summed": Description.SUMMED
});

class FoodNutrient {
  FoodNutrient({
    this.nutrient,
    this.type,
    this.foodNutrientDerivation,
    this.id,
    this.amount,
    this.dataPoints,
    this.max,
    this.min,
    this.median,
    this.minYearAcquired,
    this.nutrientAnalysisDetails,
  });

  Nutrient? nutrient;
  Type? type;
  Food? foodNutrientDerivation;
  int? id;
  double? amount;
  int? dataPoints;
  double? max;
  double? min;
  double? median;
  int? minYearAcquired;
  List<NutrientAnalysisDetail>? nutrientAnalysisDetails;

  factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
    nutrient: Nutrient.fromJson(json["nutrient"]),
    type: typeValues.map[json["type"]],
    foodNutrientDerivation: json["foodNutrientDerivation"] == null ? null : Food.fromJson(json["foodNutrientDerivation"]),
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    dataPoints: json["dataPoints"] == null ? null : json["dataPoints"],
    max: json["max"] == null ? null : json["max"].toDouble(),
    min: json["min"] == null ? null : json["min"].toDouble(),
    median: json["median"] == null ? null : json["median"].toDouble(),
    minYearAcquired: json["minYearAcquired"] == null ? null : json["minYearAcquired"],
    nutrientAnalysisDetails: json["nutrientAnalysisDetails"] == null ? null : List<NutrientAnalysisDetail>.from(json["nutrientAnalysisDetails"].map((x) => NutrientAnalysisDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nutrient": nutrient!.toJson(),
    "type": typeValues.reverse![type],
    "foodNutrientDerivation": foodNutrientDerivation == null ? null : foodNutrientDerivation!.toJson(),
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "dataPoints": dataPoints == null ? null : dataPoints,
    "max": max == null ? null : max,
    "min": min == null ? null : min,
    "median": median == null ? null : median,
    "minYearAcquired": minYearAcquired == null ? null : minYearAcquired,
    "nutrientAnalysisDetails": nutrientAnalysisDetails == null ? null : List<dynamic>.from(nutrientAnalysisDetails!.map((x) => x.toJson())),
  };
}

class Nutrient {
  Nutrient({
    this.id,
    this.number,
    this.name,
    this.rank,
    this.unitName,
  });

  int? id;
  String? number;
  String? name;
  int? rank;
  UnitName? unitName;

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
    id: json["id"],
    number: json["number"],
    name: json["name"],
    rank: json["rank"],
    unitName: unitNameValues.map[json["unitName"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "name": name,
    "rank": rank,
    "unitName": unitNameValues.reverse![unitName],
  };
}

enum UnitName { G, KCAL, MG, UNIT_NAME_G }

final unitNameValues = EnumValues({
  "g": UnitName.G,
  "kcal": UnitName.KCAL,
  "mg": UnitName.MG,
  "µg": UnitName.UNIT_NAME_G
});

class NutrientAnalysisDetail {
  NutrientAnalysisDetail({
    this.subSampleId,
    this.nutrientId,
    this.amount,
    this.labMethodTechnique,
    this.labMethodDescription,
    this.labMethodOriginalDescription,
    this.labMethodLink,
    this.nutrientAcquisitionDetails,
    this.loq,
  });

  int? subSampleId;
  int? nutrientId;
  double? amount;
  LabMethodTechnique? labMethodTechnique;
  LabMethodDescription? labMethodDescription;
  String? labMethodOriginalDescription;
  String? labMethodLink;
  List<NutrientAcquisitionDetail>? nutrientAcquisitionDetails;
  double? loq;

  factory NutrientAnalysisDetail.fromJson(Map<String, dynamic> json) => NutrientAnalysisDetail(
    subSampleId: json["subSampleId"],
    nutrientId: json["nutrientId"],
    amount: json["amount"].toDouble(),
    labMethodTechnique: labMethodTechniqueValues.map[json["labMethodTechnique"]],
    labMethodDescription: labMethodDescriptionValues.map[json["labMethodDescription"]],
    labMethodOriginalDescription: json["labMethodOriginalDescription"],
    labMethodLink: json["labMethodLink"],
    nutrientAcquisitionDetails: List<NutrientAcquisitionDetail>.from(json["nutrientAcquisitionDetails"].map((x) => NutrientAcquisitionDetail.fromJson(x))),
    loq: json["loq"] == null ? null : json["loq"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "subSampleId": subSampleId,
    "nutrientId": nutrientId,
    "amount": amount,
    "labMethodTechnique": labMethodTechniqueValues.reverse![labMethodTechnique],
    "labMethodDescription": labMethodDescriptionValues.reverse![labMethodDescription],
    "labMethodOriginalDescription": labMethodOriginalDescription,
    "labMethodLink": labMethodLink,
    "nutrientAcquisitionDetails": List<dynamic>.from(nutrientAcquisitionDetails!.map((x) => x.toJson())),
    "loq": loq == null ? null : loq,
  };
}

enum LabMethodDescription { AOAC_93406_MOD, AOAC_99003, AOAC_92206, AOAC_92303, AOAC_99143, AOAC_98214_MOD, AOAC_9850198427, AOAC_942239531795717, AOAC_97065, AOAC_944139604698534, MANN_ET_AL_JAOAC_2005_P30, AOAC_99205 }

final labMethodDescriptionValues = EnumValues({
  "AOAC 922.06": LabMethodDescription.AOAC_92206,
  "AOAC 923.03": LabMethodDescription.AOAC_92303,
  "AOAC 934.06 mod": LabMethodDescription.AOAC_93406_MOD,
  "AOAC 942.23 + 953.17 + 957.17": LabMethodDescription.AOAC_942239531795717,
  "AOAC 944.13 + 960.46 + 985.34": LabMethodDescription.AOAC_944139604698534,
  "AOAC 970.65": LabMethodDescription.AOAC_97065,
  "AOAC 982.14 mod": LabMethodDescription.AOAC_98214_MOD,
  "AOAC 985.01 + 984.27": LabMethodDescription.AOAC_9850198427,
  "AOAC 990.03": LabMethodDescription.AOAC_99003,
  "AOAC 991.43": LabMethodDescription.AOAC_99143,
  "AOAC 992.05": LabMethodDescription.AOAC_99205,
  "Mann et al. JAOAC (2005) p30": LabMethodDescription.MANN_ET_AL_JAOAC_2005_P30
});

enum LabMethodTechnique { VACUUM_OVEN, COMBUSTION, ACID_HYDROLYSIS, GRAVIMETRIC, ENZYMATIC_GRAVIMETRIC, HPLC, ICP, FLUOROMETRIC, MICROBIOLOGICAL, LC }

final labMethodTechniqueValues = EnumValues({
  "Acid hydrolysis": LabMethodTechnique.ACID_HYDROLYSIS,
  "Combustion": LabMethodTechnique.COMBUSTION,
  "Enzymatic-gravimetric": LabMethodTechnique.ENZYMATIC_GRAVIMETRIC,
  "Fluorometric": LabMethodTechnique.FLUOROMETRIC,
  "Gravimetric": LabMethodTechnique.GRAVIMETRIC,
  "HPLC": LabMethodTechnique.HPLC,
  "ICP": LabMethodTechnique.ICP,
  "LC": LabMethodTechnique.LC,
  "Microbiological": LabMethodTechnique.MICROBIOLOGICAL,
  "Vacuum oven": LabMethodTechnique.VACUUM_OVEN
});

class NutrientAcquisitionDetail {
  NutrientAcquisitionDetail({
    this.sampleUnitId,
    this.purchaseDate,
    this.storeCity,
    this.storeState,
    this.packerCity,
    this.packerState,
  });

  int? sampleUnitId;
  PurchaseDate? purchaseDate;
  StoreCity? storeCity;
  StoreState? storeState;
  PackerCity? packerCity;
  PackerState? packerState;

  factory NutrientAcquisitionDetail.fromJson(Map<String, dynamic> json) => NutrientAcquisitionDetail(
    sampleUnitId: json["sampleUnitId"],
    purchaseDate: purchaseDateValues.map[json["purchaseDate"]],
    storeCity: storeCityValues.map[json["storeCity"]],
    storeState: storeStateValues.map[json["storeState"]],
    packerCity: packerCityValues.map[json["packerCity"]],
    packerState: packerStateValues.map[json["packerState"]],
  );

  Map<String, dynamic> toJson() => {
    "sampleUnitId": sampleUnitId,
    "purchaseDate": purchaseDateValues.reverse![purchaseDate],
    "storeCity": storeCityValues.reverse![storeCity],
    "storeState": storeStateValues.reverse![storeState],
    "packerCity": packerCityValues.reverse![packerCity],
    "packerState": packerStateValues.reverse![packerState],
  };
}

enum PackerCity { CINCINNATI, LANDOVER, SELAH, YAKIMA, LANCASTER, PLEASANTON }

final packerCityValues = EnumValues({
  "Cincinnati": PackerCity.CINCINNATI,
  "Lancaster": PackerCity.LANCASTER,
  "Landover": PackerCity.LANDOVER,
  "Pleasanton": PackerCity.PLEASANTON,
  "Selah": PackerCity.SELAH,
  "Yakima": PackerCity.YAKIMA
});

enum PackerState { OH, MD, WA, PA, CA }

final packerStateValues = EnumValues({
  "CA": PackerState.CA,
  "MD": PackerState.MD,
  "OH": PackerState.OH,
  "PA": PackerState.PA,
  "WA": PackerState.WA
});

enum PurchaseDate { THE_4162020, THE_4202020, THE_552020 }

final purchaseDateValues = EnumValues({
  "4/16/2020": PurchaseDate.THE_4162020,
  "4/20/2020": PurchaseDate.THE_4202020,
  "5/5/2020": PurchaseDate.THE_552020
});

enum StoreCity { BLACKSBURG, BURTONSVILLE, BELTSVILLE, RIVERDALE_PARK, COLLEGE_PARK, HYATTSVILLE }

final storeCityValues = EnumValues({
  "Beltsville": StoreCity.BELTSVILLE,
  "Blacksburg": StoreCity.BLACKSBURG,
  "Burtonsville": StoreCity.BURTONSVILLE,
  "College Park": StoreCity.COLLEGE_PARK,
  "Hyattsville": StoreCity.HYATTSVILLE,
  "Riverdale Park": StoreCity.RIVERDALE_PARK
});

enum StoreState { VA, MD }

final storeStateValues = EnumValues({
  "MD": StoreState.MD,
  "VA": StoreState.VA
});

enum Type { FOOD_NUTRIENT }

final typeValues = EnumValues({
  "FoodNutrient": Type.FOOD_NUTRIENT
});

class InputFoodElement {
  InputFoodElement({
    this.id,
    this.foodDescription,
    this.inputFood,
  });

  int? id;
  String? foodDescription;
  InputFoodInputFood? inputFood;

  factory InputFoodElement.fromJson(Map<String, dynamic> json) => InputFoodElement(
    id: json["id"],
    foodDescription: json["foodDescription"],
    inputFood: InputFoodInputFood.fromJson(json["inputFood"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foodDescription": foodDescription,
    "inputFood": inputFood!.toJson(),
  };
}

class InputFoodInputFood {
  InputFoodInputFood({
    this.fdcId,
    this.description,
    this.publicationDate,
    this.foodAttributeTypes,
    this.foodClass,
    this.totalRefuse,
    this.dataType,
    this.foodGroup,
  });

  int? fdcId;
  String? description;
  String? publicationDate;
  List<dynamic>? foodAttributeTypes;
  String? foodClass;
  int? totalRefuse;
  String? dataType;
  Food? foodGroup;

  factory InputFoodInputFood.fromJson(Map<String, dynamic> json) => InputFoodInputFood(
    fdcId: json["fdcId"],
    description: json["description"],
    publicationDate: json["publicationDate"],
    foodAttributeTypes: List<dynamic>.from(json["foodAttributeTypes"].map((x) => x)),
    foodClass: json["foodClass"],
    totalRefuse: json["totalRefuse"],
    dataType: json["dataType"],
    foodGroup: Food.fromJson(json["foodGroup"]),
  );

  Map<String, dynamic> toJson() => {
    "fdcId": fdcId,
    "description": description,
    "publicationDate": publicationDate,
    "foodAttributeTypes": List<dynamic>.from(foodAttributeTypes!.map((x) => x)),
    "foodClass": foodClass,
    "totalRefuse": totalRefuse,
    "dataType": dataType,
    "foodGroup": foodGroup!.toJson(),
  };
}

class NutrientConversionFactor {
  NutrientConversionFactor({
    this.id,
    this.proteinValue,
    this.fatValue,
    this.carbohydrateValue,
    this.type,
    this.name,
    this.value,
  });

  int? id;
  double? proteinValue;
  double? fatValue;
  double? carbohydrateValue;
  String? type;
  String? name;
  double? value;

  factory NutrientConversionFactor.fromJson(Map<String, dynamic> json) => NutrientConversionFactor(
    id: json["id"],
    proteinValue: json["proteinValue"] == null ? null : json["proteinValue"].toDouble(),
    fatValue: json["fatValue"] == null ? null : json["fatValue"].toDouble(),
    carbohydrateValue: json["carbohydrateValue"] == null ? null : json["carbohydrateValue"].toDouble(),
    type: json["type"],
    name: json["name"],
    value: json["value"] == null ? null : json["value"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "proteinValue": proteinValue == null ? null : proteinValue,
    "fatValue": fatValue == null ? null : fatValue,
    "carbohydrateValue": carbohydrateValue == null ? null : carbohydrateValue,
    "type": type,
    "name": name,
    "value": value == null ? null : value,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
