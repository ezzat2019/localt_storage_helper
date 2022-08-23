import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_test_dart/database/db_constant.dart';
import 'package:test_test_dart/database/db_helper.dart';
import 'package:test_test_dart/hive/hive_helper.dart';
import 'package:test_test_dart/hive/hive_model/product_model.dart';
import 'package:test_test_dart/hive/hive_model/user_model.dart';

class LocalScreen extends StatefulWidget {
  const LocalScreen({Key? key}) : super(key: key);

  @override
  _LocalScreenState createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        Center(
          child: RaisedButton(
            onPressed: () async {
              await db.insert(DB_USER_TABLE_NAME,
                  {"name": "ezzat", "age": 38}).then((value) {
                print(value.toString());
              });
            },
            child: Text("insert user SQFLITE"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            await db.insert(DB_PRODUCT_TABLE_NAME,
                {"product_name": "car", "price": 200023535.16}).then((value) {
              print(value.toString());
            });
          },
          child: Text("insert product SQFLITE"),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            await db.insert(DB_FAVOURITE_TABLE_NAME,
                {"fk_id_user": "2", "fk_id_product": "1"});
          },
          child: Text("insert favourite SQFLITE"),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            var users = await db.query(DB_USER_TABLE_NAME);
            var products = await db.query(DB_PRODUCT_TABLE_NAME);
            var fav =
                await db.query(DB_FAVOURITE_TABLE_NAME, where: "fk_id_user=2");
            print((users.toString()));
            print((products.toString()));

            print((fav.toString()));
          },
          child: Text("read SQFLITE"),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            UserModel uEzzat = UserModel("ezzat", 29);
            UserModel u2 = UserModel("soltan", 44);
            hiveHelper.userBox.put("1", uEzzat).then((value) {});
            hiveHelper.userBox.put("2", u2).then((value) {});
            ProductModel p = ProductModel("car");
            p.assignTo = HiveList(hiveHelper.userBox);
            p.assignTo!.add(uEzzat);
            p.assignTo!.add(u2);
            uEzzat.age=60;

            hiveHelper.productBox.put("3", p).then((value) {});
            hiveHelper.productBox
                .put("4", ProductModel("bus"))
                .then((value) {});
          },
          child: Text("write hive"),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            UserModel? userModel = hiveHelper.userBox.get("1");

            ProductModel? productModel = hiveHelper.productBox.get("3");

            print(userModel.toString());
            print(productModel.toString());
          },
          child: Text("read hive"),
        ),
      ],
    ));
  }
}
