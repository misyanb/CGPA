import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  late int id;
  late String username;
  late String password;
  double? cgpa;

  User({required this.username, required this.password, this.cgpa, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'cgpa': cgpa,
    };
  }
}

class DatabaseHelper {
  static const String dbName = 'cgpa_database.db';
  static DatabaseHelper? _instance;
  late Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance!;
  }

  Future<void> initializeDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    _database = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        cgpa REAL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add any necessary upgrade logic here
      // For example, you might add a new column or modify existing ones
    }
  }

  Future<int> insertUser(User user) async {
    return await _database.insert('users', user.toMap());
  }

  Future<User?> getUser(String username, String password) async {
    List<Map<String, dynamic>> maps = await _database.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        username: maps[0]['username'],
        password: maps[0]['password'],
        cgpa: maps[0]['cgpa'],
      );
    }
    return null;
  }

  Future<void> updateCGPA(User user) async {
    await _database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> closeDatabase() async {
    await _database.close();
  }

  Future<void> saveSemestersToDatabase(int semesters) async {
    try {
      await _database.insert('cgpa_table', {'semesters': semesters});
    } catch (e) {
      print('Error saving semesters to the database: $e');
    }
  }
}
