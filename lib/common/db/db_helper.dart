import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'bank.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE wallet (id INTEGER PRIMARY KEY, name TEXT, balance INTEGER, image INTEGER)');
    await db.execute('CREATE TABLE type (id INTEGER PRIMARY KEY, name TEXT)');
    await db.execute('CREATE TABLE category (id INTEGER PRIMARY KEY, name TEXT, type INTEGER, icon INTEGER, color TEXT, FOREIGN KEY(type) REFERENCES type(id))');
    await db.execute('CREATE TABLE trans (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER, date TEXT, wallet INTEGER, type INTEGER, category INTEGER,'
        'FOREIGN KEY(wallet) REFERENCES wallet(id), FOREIGN KEY(type) REFERENCES type(id), FOREIGN KEY(category) REFERENCES category(id))');

    //Input types
    await db.execute("INSERT INTO type (name) VALUES ('income')");
    await db.execute("INSERT INTO type (name) VALUES ('outcome')");
    await db.execute("INSERT INTO type (name) VALUES ('transfer')");

    //Input Categories
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Gaji', 1, 64779, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Hadiah', 1, 65157, '#FFDFBA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Investasi', 1, 61738, '#FFFFBA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Penjualan', 1, 62575, '#BAFFC9')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Pinjaman', 1, 61719, '#BAE1FF')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Piutang', 1, 61718, '#ECBEE5')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Komisi', 1, 61869, '#C8C8C8')");

    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Makanan', 2, 62042, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Rumah', 2, 62172, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Hiburan', 2, 62103, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Belanja', 2, 62618, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Kesehatan', 2, 63214, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Pakaian', 2, 64122, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Telepon', 2, 62450, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Peliharaan', 2, 62441, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Sosial', 2, 64555, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Pendidikan', 2, 62580, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Mobil', 2, 61707, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Elektronik', 2, 65488, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Anak', 2, 62183, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Perjalanan', 2, 61469, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Pajak', 2, 62537, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Listrik', 2, 62017, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Internet', 2, 62889, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Air', 2, 62860, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Asuransi', 2, 62821, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Bahan Makanan', 2, 61711, '#FFB3BA')");
    await db.execute("INSERT INTO category (name, type, icon, color) VALUES ('Kantor', 2, 61654, '#FFB3BA')");
  }

  // //Wallet
  // Future<int> addWallet(Wallet wallet) async {
  //   var dbClient = await db;
  //   return await dbClient.insert('wallet', wallet.toMap());
  // }
  //
  // Future<List<Wallet>> getWallets() async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query('wallet', columns: ['id', 'name', 'balance', 'image']);
  //   List<Wallet> wallets = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       wallets.add(Wallet.fromMap(maps[i]));
  //     }
  //   }
  //   return wallets;
  // }
  //
  // Future<Wallet> getWallet(int id) async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query('wallet',
  //     where: "id = ?",
  //     whereArgs: [id]
  //   );
  //   return Wallet.fromMap(maps.first);
  // }
  //
  // Future<int> deleteWallet(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(
  //     'wallet',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
  //
  // Future<int> updateWallet(Wallet wallet) async {
  //   var dbClient = await db;
  //   return await dbClient.update(
  //     'wallet',
  //     wallet.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [wallet.id],
  //   );
  // }
  //
  // //Category
  // Future<int> addCategory(Category category) async {
  //   var dbClient = await db;
  //   return await dbClient.insert('category', category.toMap());
  // }
  //
  // Future<List<Category>> getCategories(int type) async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query(
  //     'category',
  //     columns: ['id', 'name', 'type', 'icon', 'color'],
  //     where: "type = ?",
  //     whereArgs: [type]
  //   );
  //   List<Category> categories = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       categories.add(Category.fromMap(maps[i]));
  //     }
  //   }
  //   return categories;
  // }
  //
  // Future<Category> getCategory(int id) async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query('category',
  //     where: "id = ?",
  //     whereArgs: [id]
  //   );
  //   return Category.fromMap(maps.first);
  // }
  //
  // Future<int> deleteCategory(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(
  //     'category',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
  //
  // Future<int> updateCategory(Category category) async {
  //   var dbClient = await db;
  //   return await dbClient.update(
  //     'category',
  //     category.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [category.id],
  //   );
  // }

  Future close() async {
    var dbClient = await db;
    dbClient?.close();
  }
}
