import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'personmodel.dart';

class DBUtil {
  Database? _db;
  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'people.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  void onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE persons(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, amount TEXT, buyPrice TEXT)",
    );
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  Future<int> create(Person person) async {
    var dbCheck = await db;
    return await dbCheck!.rawInsert(
        "INSERT INTO persons(name, amount, buyPrice) VALUES('${person.name}','${person.amount}','${person.buyPrice}')");
  }

  Future<Person> read(String name) async {
    var dbReady = await db;
    var read =
        await dbReady!.rawQuery("SELECT * FROM persons WHERE name='$name'");
    return Person.fromMap(read[0]);
  }

  Future<int> update(Person person) async {
    var dbReady = await db;
    return await dbReady!.rawInsert(
        "UPDATE persons SET name='${person.name}', amount = '${person.amount}' WHERE name = '${person.name}' ");
  }

  Future<int> delete(String name, String amount) async {
    var dbReady = await db;
    return await dbReady!.rawInsert(
        "DELETE FROM persons WHERE name = '$name' AND amount = '$amount'");
  }

  Future<int> delete2(int id) async {
    var dbReady = await db;
    return await dbReady!.rawInsert("DELETE FROM persons WHERE id = '$id'");
  }

  Future<List<Person>> readAll() async {
    var dbReady = await db;
    List<Map> list = await dbReady!.rawQuery("SELECT * FROM persons");
    List<Person> person = [];
    for (int i = 0; i < list.length; i++) {
      person.add(Person(
        list[i]['id'],
        list[i]['name'],
        list[i]['amount'],
        list[i]['buyPrice'],
      ));
    }
    return person;
  }
}
