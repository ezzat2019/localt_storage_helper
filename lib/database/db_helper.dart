
import 'package:sqflite/sqflite.dart';
import 'package:test_test_dart/database/db_constant.dart';

late Database db;
class DBHelper{
  init()async{
    print("db create start");
    db = await openDatabase('my_db1.db',version: 1,onCreate: (db, version) async{
      await db.execute(
          'CREATE TABLE $DB_USER_TABLE_NAME (id_user INTEGER PRIMARY KEY, name TEXT, age integer)');

      await db.execute(
          'CREATE TABLE $DB_PRODUCT_TABLE_NAME (id_product INTEGER PRIMARY KEY, product_name TEXT, price real)');


      await db.execute(
            'CREATE TABLE $DB_FAVOURITE_TABLE_NAME (fav_id INTEGER PRIMARY KEY,fk_id_user INTEGER'
                ',fk_id_product INTEGER ,'
                'foreign key (fk_id_user) references $DB_USER_TABLE_NAME (id_user),'
                'foreign key (fk_id_product) references $DB_PRODUCT_TABLE_NAME (id_product))');

      print("db created");
    },);

  }

}