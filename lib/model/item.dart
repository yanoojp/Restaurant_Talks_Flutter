import '../fixedDatas/variables.dart';

class Item {

  Item({
    this.accountId = '',
    this.itenName = '',
    this.itemCount = '0',
    this.itemCategory = sortByCategoryLabel,
    this.itemDetail = '',
    required this.updatedAt,
  });
  String accountId;
  String itenName;
  String itemCount;
  String itemCategory;
  String itemDetail;
  DateTime updatedAt;
}
