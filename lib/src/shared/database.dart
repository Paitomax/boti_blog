import 'package:botiblog/src/shared/security/encryption.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final String databaseName = 'boti_blog.db';
  static final int databaseVersion = 1;

  static Future<Database> openLocalDatabase() async {
    final databasePath = await databasesPath();
    final database = await openDatabase(databasePath, version: databaseVersion,
        onCreate: (db, version) async {
      await _creteDatabase(db);
      await _mockUser(db);
      await _mockPost(db);
    });
    return database;
  }

  static Future<String> databasesPath() async {
    var databasesPath = await getDatabasesPath();
    return "$databasesPath/$databaseName";
  }

  static Future<void> _creteDatabase(Database db) async {
    await db.execute(
        "CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)");
    await db.execute(
        "CREATE TABLE UserPost (id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, date TEXT, userId INTEGER, FOREIGN KEY(userId) REFERENCES User(id))");
  }

  static Future<void> _mockUser(Database db) async {
    await db.insert("User", {
      'name': 'José',
      'email': 'jose@teste.com.br',
      'password': Encryption.encrypt('123456')
    });
    await db.insert("User", {
      'name': 'Claudia',
      'email': 'claudia@teste.com.br',
      'password': Encryption.encrypt('senha123')
    });
    await db.insert("User", {
      'name': 'Marcondes',
      'email': 'marcondes@teste.com.br',
      'password': Encryption.encrypt('Tobias000')
    });
  }

  static Future<void> _mockPost(Database db) async {
    await db.insert("UserPost", {
      'text':
          'Preciso de sugestões de tecnologia para utilizar no novo projeto',
      'date': '2020-05-01T16:00:00Z',
      'userId': 1
    });
    await db.insert("UserPost", {
      'text': 'O cheirinho de sucesso está no ar',
      'date': '2020-02-02T09:00:00Z',
      'userId': 2
    });
    await db.insert("UserPost", {
      'text': 'Alguém viu minha garrafinha?',
      'date': '2020-02-03T10:00:00Z',
      'userId': 2
    });
    await db.insert("UserPost", {
      'text': 'Estou afim de fazer uma reunião, mais alguém?',
      'date': '2020-02-02T20:00:00Z',
      'userId': 3
    });
  }
}
