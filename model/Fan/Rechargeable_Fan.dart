import 'package:testoop_danghoa/Calculate.dart';
import 'package:testoop_danghoa/EnterData.dart';
import 'Fan.dart';

class Rechargeable_Fan extends Fan{
  num batteryCapacity;
  Rechargeable_Fan(String ID, String productName, num? price, String whereProduction,this.batteryCapacity) : super(ID, productName, price, whereProduction);
  Rechargeable_Fan.noParameter(this.batteryCapacity):super('', '', 0, '');
  num GetBatteryCapacity() => batteryCapacity;
  void SetBatteryCapacity(num value) {
    batteryCapacity = value;
  }
  @override
  String toStringValue() {
    String content = "\tMáy Quạt : <$ID> <Loại máy quạt : Máy quạt sạc điện> "+super.toStringValue()+" \tDung lượng pin: <$batteryCapacity>";
    return content;
  }
  @override
  void  enterData(){
    super.enterData();
    batteryCapacity = enterNum("\t\t\t\t\t\tDung lượng pin: ")!;
    price = getRechargeableFanPrice(batteryCapacity);
  }
}