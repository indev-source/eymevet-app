import 'dart:io';
import 'package:flutter_app/models/product_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductDatabaseProvider{
    ProductDatabaseProvider._();
    static final ProductDatabaseProvider db = ProductDatabaseProvider._();
    Database _database;

    //para evitar que abra varias conexiones una y otra vez podamos usar algo como esto...
    Future<Database> get database async{
        if(_database != null) return _database;
        _database = await getDatabaseInstance;
        return _database;
    }

    Future<Database> get getDatabaseInstance async{
        Directory directory = await getApplicationDocumentsDirectory();
        String path = join(directory.path,'products.db');
        return await openDatabase(path,version:1,
            onCreate:(Database db, int version) async{
                await db.execute("CREATE TABLE products(id integer primary key, name TEXT,price1 double,price2 float, price3 float, marca TEXT)");
            }
        );
    }

    //query
    //mostrar todos los clientes de la base de datos
    Future<List<Product>> getallProducts() async {
        final db = await database;
        var response = await db.query("products");
        List<Product> list = response.map((c)=>Product.fromMap(c)).toList();
        return list;
    }

    //mostrar un cliente por el id de la base de datos
    Future<Product> getProductswithId(int id) async {
        final db = await database;
        var response = await db.query("products", where:"id = ?",whereArgs: [id]);
        return response.isNotEmpty ? Product.fromMap(response.first): null;
    }

    //insert
    addProductToDatabase(Product product) async{
        final db = await database;
        var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM products");
        int id = table.first['id'];
        product.id = id;
        var raw = await db.insert(
            "products",
            product.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace
        );
        return raw;
    }
    //delete client with id
    deleteProductWithId(int id) async {
        final db = await database;
        return db.delete("products",where:"id=?", whereArgs: [id]);
    }

    deleteAllProducts() async {
        final db = await database;
        db.delete("products");
    }

    //update
    updateProduct(Product product) async {
        final db = await database;
        var response = await db.update("products",product.toMap(),where: "id=?",whereArgs:[product.id]);
        return response;
    }
}