import 'package:flutter_application_5/models/taches.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ffi';
import 'package:path_provider/path_provider.dart';
//cette classe permet d'effectuer les opérations sur la BD
class DatabaseHelper{
  static DatabaseHelper _databaseHelper=DatabaseHelper();
  late Database _database;
  String tacheTable = 'tache_table';
  String colId = 'id';
  String colTitre = 'titre';
  String colDesc = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance();
  Future<Database>_initialize() async{
    Directory direc = await getApplicationDocumentsDirectory();
    String path = direc.path + 'taches.db';
    return await openDatabase(path,version:1,onCreate: _createDb );
  }
  Future<Database> get database async{
    
    if(_database == null){
      _database = await _initialize();
    }
    return _database;
  }
  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  void _createDb(Database db,int version) async{
    await db.execute('CREATE TABLE $tacheTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitre TEXT,$colDesc TEXT,$colDate TEXT)');
  }
  Future<List<Map<String,dynamic>>>getMapList () async{
    Database db = await this._database;
    //var result = await db.rawQuery('SELECT * FROM $tacheTable');
    var result = await db.query(tacheTable); 
    return result;
  }
  Future<int> insertTache(Taches taches) async{
    var db = await this._database;
    var result = await db.insert(tacheTable, taches.toMap());
    return result;
  }
  Future<int> updateTache(Taches taches) async{
    var db = await this._database;
    var result = await db.update(tacheTable, taches.toMap(), where: '$colId = ?',whereArgs: [taches.id]);
    return result;
  }
   Future<int> deleteTache(int id) async{
    var db = await this._database;
    var result = await db.rawDelete('DELETE FROM $tacheTable WHERE $colId = $id');
    return result;
  }
  Future<int?>getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) from  $tacheTable'); 
    int? result = Sqflite.firstIntValue(x);
    return result;
  }
}