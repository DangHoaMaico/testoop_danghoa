import '../Electrical_Equipment.dart';
 class Fan extends ElectricalEquipment{
  Fan(String iD, String productName, num? price, String whereProduction) : super(iD, productName, price, whereProduction);
  Fan.noParameter() : super('', '', null, '');
}