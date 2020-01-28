import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/client_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class ClientDataBaseProvider{
    ClientDataBaseProvider._();
    static final ClientDataBaseProvider db = ClientDataBaseProvider._();
    Database _database;

    //para evitar que abra varias conexiones una y otra vez podamos usar algo como esto...
    Future<Database> get database async{
        if(_database != null) return _database;
        _database = await getDatabaseInstance;
        return _database;
    }

    Future<Database> get getDatabaseInstance async{
        Directory directory = await getApplicationDocumentsDirectory();
        String path = join(directory.path,'client.db');
        return await openDatabase(path,version:1,
            onCreate:(Database db, int version) async{
                await db.execute("CREATE TABLE client(id integer primary key, fullname TEXT,address TEXT,phone TEXT)");
            }
        );
    }

    //query
    //mostrar todos los clientes de la base de datos
    Future<List<Client>> getAllClients() async {
        final db = await database;
        var response = await db.query("client");
        List<Client> list = response.map((c)=>Client.fromMap(c)).toList();
        return list;
    }

    //mostrar un cliente por el id de la base de datos
    Future<Client> getClientWithId(int id) async {
        final db = await database;
        var response = await db.query("client", where:"id = ?",whereArgs: [id]);
        return response.isNotEmpty ? Client.fromMap(response.first): null;
    }

    //insert
    addClientToDatabase(Client client) async{
        final db = await database;
        var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM client");
        int id = table.first['id'];
        client.id = id;
        var raw = await db.insert(
            "client",
            client.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace
        );
        return raw;
    }
    //delete client with id
    deleteClientWithId(int id) async {
        final db = await database;
        return db.delete("client",where:"id=?", whereArgs: [id]);
    }

    deleteAllClients() async {
        final db = await database;
        db.delete("client");
    }

    //update
    updateClient(Client client) async {
        final db = await database;
        var response = await db.update("client",client.toMap(),where: "id=?",whereArgs:[client.id]);
        return response;
    }
}