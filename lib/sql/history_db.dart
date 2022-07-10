import 'package:path/path.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:sqflite/sqflite.dart';

enum QueryType {
  qrcodeType,
  contentType,
}

class HistoryDB {
  static const _databaseName = 'historyDatabase.db';
  static const _databaseVersion = 1;

  static const tableName = 'history';

  static const columnId = 'id';
  static const columnCreateDate = 'createDate';
  static const columnQrcodeType = 'qrcodeType';
  static const columnContentType = 'contentType';
  static const columnContent = 'content';
  static const columnFavorite = 'favorite';

  static Database? database;

  static Future<Database?> getDataBase() async {
    if (database != null) {
      return database;
    } else {
      return await initDataBase();
    }
  }

  static Future<Database?> initDataBase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE $tableName("
            "$columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
            "$columnCreateDate TEXT,"
            "$columnQrcodeType TEXT,"
            "$columnContentType TEXT,"
            "$columnContent TEXT,"
            "$columnFavorite TEXT"
            ")");
      },
      version: _databaseVersion,
    );
    return database;
  }

  //display all data
  static Future<List<HistoryModel>> displayAllData() async {
    final Database? db = await getDataBase();
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) {
      return HistoryModel(
        id: maps[index][columnId],
        createDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(maps[index][columnCreateDate]),
        ),
        qrcodeType: maps[index][columnQrcodeType],
        favorite: maps[index][columnFavorite].toString() == 'true',
        content: maps[index][columnContent],
        contentType: maps[index][columnContentType],
      );
    });
  }

  //query data
  static Future<List<HistoryModel>> queryData({
    required QueryType queryType,
    List<String>? query,
  }) async {
    final Database? db = await getDataBase();

    String? whereString;
    List<dynamic>? whereArguments;
    switch (queryType) {
      case QueryType.qrcodeType:
        whereString = '$columnQrcodeType = ?';
        whereArguments = query;
        break;
      case QueryType.contentType:
        whereString = '$columnContentType = ?';
        whereArguments = query;
        break;
    }
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: whereString,
      whereArgs: whereArguments,
    );

    return List.generate(maps.length, (index) {
      return HistoryModel(
        id: maps[index][columnId],
        createDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(maps[index][columnCreateDate]),
        ),
        qrcodeType: maps[index][columnQrcodeType],
        favorite: maps[index][columnFavorite].toString() == 'true',
        content: maps[index][columnContent],
        contentType: maps[index][columnContentType],
      );
    });
  }

  static Future<int?> insertData(HistoryModel historyModel) async {
    final Database? db = await getDataBase();
    try {
      return await db!.insert(tableName, historyModel.toMap());
    } catch (_) {
      return null;
    }
  }

  static Future<bool> updateData(
      HistoryModel historyModel) async {
    final Database? db = await getDataBase();

    await db!.update(
      tableName,
      historyModel.toMap(),
      where: '$columnId = ?',
      whereArgs: [historyModel.id],
    );
    return true;
  }

  static Future<void> deleteData(int id) async {
    final db = await getDataBase();

    await db!.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return;
  }
}
