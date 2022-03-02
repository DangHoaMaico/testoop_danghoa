import '../Electrical_Equipment.dart';

abstract class AirConditioner extends ElectricalEquipment{
  bool hasInverter;
  AirConditioner(String iD, String nameProduct, num price, String whereProduction,this.hasInverter) : super(iD, nameProduct, price, whereProduction);
  AirConditioner.noParameter(this.hasInverter):super('', '', 0, '');
}