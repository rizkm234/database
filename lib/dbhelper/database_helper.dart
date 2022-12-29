import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:database/model/contacts_model.dart';

class dataBaseHelper {
  final String tableContacts = 'contactsTable';
  final String columnId = 'id';
  final String columnNameFirst = 'fName';
  final String columnNameLast = 'lName';
  final String columnPhone = 'phone';
  final String columnMail = 'mail';

  static Database? _db;

  Future<Database> get db async{
    if(_db != null){
      return _db! ;
    }
    _db = await initDb();

    return _db!;
  }

  initDb()async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'contacts.db');
    var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db , int newVersion) async{
    var sql = 'CREATE TABLE $tableContacts ($columnId INTEGER PRIMARY KEY,'
        '$columnNameFirst TEXT ,$columnNameLast TEXT ,'
        '$columnMail TEXT ,$columnPhone TEXT)';
    await db.execute(sql);
  }

  Future<int> saveContacts(contactsModel contacts) async{
    var dbClient = await db;
    var result = await dbClient.insert(  tableContacts , contacts.toMap() );
    return result;
  }

  Future<List> getAllContacts() async{
    var dbClient = await db;
    var result = await dbClient.query(
        tableContacts ,
        columns: [columnId,columnNameFirst,
          columnNameLast,columnMail,
          columnPhone]
    );
    return result.toList();
  }

  Future<int?> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableContacts'));
  }

  Future<contactsModel?> getContacts(int id) async{
    var dbClient = await db;
    List<Map> result = await dbClient.query(
        tableContacts ,
        columns: [columnId,columnNameFirst,
          columnNameLast,columnMail,
          columnPhone],where: '$columnId = ?',whereArgs: ['id']
    );

    if(result.isNotEmpty){
      return contactsModel.fromMap(result.first);
    }

    return null;
  }

  Future<int> updateContact(contactsModel contacts)async{
    var dbClient = await db;
    return await dbClient.update(
        tableContacts , contacts.toMap(), where: '$columnId = ?',whereArgs: [ contacts.id ]
    );
  }

  Future<int> deleteContacts(int id)async{
    var dbClient = await db;
    return await dbClient.delete(
        tableContacts ,   where: '$columnId = ?',whereArgs: [id]
    );
  }

  Future  close()async{
    var dbClient = await db;
    return await dbClient.close();
  }
}