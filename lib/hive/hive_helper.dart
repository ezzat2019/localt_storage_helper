import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_test_dart/hive/hive_model/product_model.dart';
import 'package:test_test_dart/hive/hive_model/user_model.dart';
HiveHelper hiveHelper=HiveHelper();
class HiveHelper {
  late Box box;
  late Box<UserModel> userBox;
  late Box<ProductModel> productBox;
  init()async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
     Hive.init(tempPath);
     Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(UserModelAdapter());

     box = await Hive.openBox(HiveConstant.MY_BOX);
    userBox = await Hive.openBox(HiveConstant.USER_BOX);
    productBox = await Hive.openBox(HiveConstant.PRODUCT_BOX);
  }
  writeBox(String name)async{
    await box.put(HiveConstant.BOX_KEY,name);
    print("success write");
  }
  readBox(String key)async{
   String data= await box.get(key);
    print("read");
    print(data);

  }

}
abstract class HiveConstant{
 static final  MY_BOX="my_box_first";
 static final  USER_BOX="user_box";
 static final  PRODUCT_BOX="product_box";
 static final  BOX_KEY="box_key";
}