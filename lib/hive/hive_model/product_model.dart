import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject{
  @HiveField(0)
  String productName;

  @HiveField(1)
  HiveList? assignTo;

  ProductModel(this.productName);

  @override
  String toString() {
    return 'ProductModel{productName: $productName, assignTo: $assignTo}';
  }
}