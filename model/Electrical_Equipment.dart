import 'package:testoop_danghoa/EnterData.dart';

abstract class Electrical_Equipment{
  late String ID;
  late String productName;
  late num? price;
  late String whereProduction;
  Electrical_Equipment(this.ID,this.productName,this.price,this.whereProduction);
  String toStringValue(){
    return "\tTên sản phầm: <$productName> \tNơi sản xuất: <$whereProduction> \n\tGiá bán: <$price> ";
  }
  Electrical_Equipment.noParameter() ;
  void  enterData(){
    ID = enterString("\t\t\t\t\t\tNhập mã: ")!;
    productName = enterString("\t\t\t\t\t\tTên sản phẩm: ")!;
    whereProduction = enterString("\t\t\t\t\t\tNơi sản xuất: ")!;
  }
}