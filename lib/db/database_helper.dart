import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase{
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 3;
  static final _tableName = 'myTable';

  static final columnId = '_id';
  static final columnName = 'name';
  static final water = 'water';
  static final protein = 'protein';
  static final fat = 'fat';
  static final carbohydrate = 'carbohydrate';
  static final sugar = 'sugar';
  static final sodium = 'sodium';
  static final page = 'page';
  static final amount = 'amount';
  static final unit = 'unit';


  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  static Database? _database;//added late to deal with initialization error
  Future<Database?> get database async{
    if(_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  Future<bool> databaseExists() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return databaseFactory.databaseExists(path);
  }
  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final floatType = 'REAL NOT NULL';

    db.execute(
        '''
      CREATE TABLE $_tableName(
      ${LocalFoodFields.columnId} $idType,
      ${LocalFoodFields.columnName} $textType,
      ${LocalFoodFields.water} $floatType,
      ${LocalFoodFields.protein} $floatType,
      ${LocalFoodFields.fat} $floatType,
      ${LocalFoodFields.carbohydrate} $floatType,
      ${LocalFoodFields.sugar} $floatType,
      ${LocalFoodFields.sodium} $floatType,
      ${LocalFoodFields.page} $integerType,
      ${LocalFoodFields.amount} $integerType,
      ${LocalFoodFields.unit} $textType
      )
      '''
    );
  }
  Future<int> insert(LocalFood food) async{//might want to change to our own id's and figure out how duplicates work here.
    Database? db = await instance.database;

    return await db!.insert(_tableName, food.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<LocalFood> readFood(int columnId) async{
    final db = await instance.database;
    final maps = await db!.query(
        _tableName,
        columns: LocalFoodFields.values,
        where: '${LocalFoodFields.columnId} = ?',
        whereArgs: [columnId]
    );
    if(maps.isNotEmpty){
      return LocalFood.fromJson(maps.first);
    } else{
      throw Exception('ID $columnId not found');
    }
  }

  Future<List<LocalFood>> readAllFood() async{
    final db = await instance.database;
    final orderBy = '${LocalFoodFields.columnName} ASC';
    final result = await db!.query(_tableName, orderBy: orderBy);
    result.asMap();
    return result.map((json) => LocalFood.fromJson(json)).toList();
  }
  Future<List<Map<String,dynamic>>> queryAll() async{
    Database? db = await instance.database;
    return await db!.query(_tableName);
  }
  Future<int> update (LocalFood food) async{
    Database? db = await instance.database;

    return await db!.update(
        _tableName,
        food.toJson(),
        where: '${LocalFoodFields.columnId} = ?',
        whereArgs: [food.columnId]
    );
  }
  Future<int> delete(int id) async{
    Database? db = await instance.database;
    return await db!.delete(_tableName, where: '${LocalFoodFields.columnId} = ?', whereArgs: [id]);
    //how well is this work?

  }
  Future close() async {
    final db = await instance.database;

    db!.close();
  }
}

class LocalFood{
  final int columnId;
  final String columnName;
  final double water;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double sugar;
  final double sodium;
  final int page;
  final int amount;
  final String unit;

  const LocalFood({
    required this.columnId,
    required this.columnName,
    required this.water,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.sugar,
    required this.sodium,
    required this.page,
    required this.amount,
    required this.unit
  });
  static LocalFood fromJson(Map<String, Object?> json) => LocalFood(
    columnId: json[LocalFoodFields.columnId] as int,
    columnName: json[LocalFoodFields.columnName] as String,
    water: json[LocalFoodFields.water] as double,
    protein: json[LocalFoodFields.protein] as double,
    fat: json[LocalFoodFields.fat] as double,
    carbohydrate: json[LocalFoodFields.carbohydrate] as double,
    sugar: json[LocalFoodFields.sugar] as double,
    sodium: json[LocalFoodFields.sodium] as double,
    page: json[LocalFoodFields.page] as int,
    amount: json[LocalFoodFields.amount] as int,
    unit: json[LocalFoodFields.unit] as String,
  );

  Map<String, Object?> toJson() =>{
    LocalFoodFields.columnId: columnId,
    LocalFoodFields.columnName: columnName,
    LocalFoodFields.water: water,
    LocalFoodFields.protein: protein,
    LocalFoodFields.fat: fat,
    LocalFoodFields.carbohydrate: carbohydrate,
    LocalFoodFields.sugar: sugar,
    LocalFoodFields.sodium: sodium,
    LocalFoodFields.page: page,
    LocalFoodFields.amount: amount,
    LocalFoodFields.unit: unit,
  };
}
class LocalFoodFields{
  static final List<String> values = [
    columnId, columnName, water, protein, fat, carbohydrate, sugar, sodium, page, amount, unit
  ];
  static final columnId = '_id';
  static final columnName = 'name';
  static final water = 'water';
  static final protein = 'protein';
  static final fat = 'fat';
  static final carbohydrate = 'carbohydrate';
  static final sugar = 'sugar';
  static final sodium = 'sodium';
  static final page = 'page';
  static final amount = 'amount';
  static final unit = 'unit';
}

