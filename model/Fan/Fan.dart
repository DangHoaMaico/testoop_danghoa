import '../Electrical_Equipment.dart';
 class Fan extends ElectricalEquipment{
  Fan(String ID, String productName, num? price, String whereProduction) : super(ID, productName, price, whereProduction);
  Fan.noParameter() : super('', '', null, '');
}