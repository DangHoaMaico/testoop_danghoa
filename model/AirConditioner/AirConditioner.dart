import '../Electrical_Equipment.dart';

abstract class AirConditioner extends ElectricalEquipment{
  bool hasInverter;
  AirConditioner(String ID, String nameProduct, num price, String whereProduction,this.hasInverter) : super(ID, nameProduct, price, whereProduction);
  AirConditioner.noParameter(this.hasInverter):super('', '', 0, '');
}