import 'package:testoop_danghoa/EnterData.dart';

import '../../bin/testoop_danghoa.dart';

abstract class ElectricalEquipment{
  late String iD;
  late String productName;
  late num? price;
  late String whereProduction;
  ElectricalEquipment(this.iD,this.productName,this.price,this.whereProduction);
  String toStringValue(){
    return "\t\tTên sản phầm: $productName \tNơi sản xuất: $whereProduction \n\tGiá bán: $price ";
  }
  ElectricalEquipment.noParameter() ;
  void  enterData(){
    iD = enterStringAndCallFunction("\t\t\t\t\t\tNhập mã: ",menu)!;
    productName = enterStringAndCallFunction("\t\t\t\t\t\tTên sản phẩm: ",menu)!;
    whereProduction = enterStringAndCallFunction("\t\t\t\t\t\tNơi sản xuất: ",menu)!;
  }
}