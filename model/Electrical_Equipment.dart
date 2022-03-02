import 'package:testoop_danghoa/EnterData.dart';

abstract class ElectricalEquipment{
  late String iD;
  late String productName;
  late num? price;
  late String whereProduction;
  ElectricalEquipment(this.iD,this.productName,this.price,this.whereProduction);
  String toStringValue(){
    return "\tTên sản phầm: <$productName> \tNơi sản xuất: <$whereProduction> \n\tGiá bán: <$price> ";
  }
  ElectricalEquipment.noParameter() ;
  void  enterData(){
    iD = enterString("\t\t\t\t\t\tNhập mã: ")!;
    productName = enterString("\t\t\t\t\t\tTên sản phẩm: ")!;
    whereProduction = enterString("\t\t\t\t\t\tNơi sản xuất: ")!;
  }
}