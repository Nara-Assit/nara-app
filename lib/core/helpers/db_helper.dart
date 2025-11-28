// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDatabaseHelper {
//   static Database? _db;
//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await initDB();

//     return _db!;
//   }

//   static Future<Database> initDB() async {
//     final dbPath = await getDatabasesPath();

//     final path = join(dbPath, 'items.db');
//     //  await deleteDatabase(path);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE items(
//             id TEXT,

//           )
//         ''');
//         await db.execute('''
//           CREATE TABLE myChats(
//             id TEXT,

//           )
//         ''');
//         await db.execute('''
//           CREATE TABLE allChats(
//             id TEXT,

//           )
//         ''');
//       },
//     );
//   }
// }
