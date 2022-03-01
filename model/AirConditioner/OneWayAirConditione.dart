import 'package:testoop_danghoa/Calculate.dart';
import 'package:testoop_danghoa/EnterData.dart';

import 'AirConditioner.dart';

class OneWayAirConditioner extends AirConditioner {
  OneWayAirConditioner(String ID, String nameProduct, num price, String whereProduction, bool hasInverter) : super(ID, nameProduct, price, whereProduction, hasInverter);
  OneWayAirConditioner.noParameter():super('', '', 0, '',false);
  @override
  String toStringValue() {
    String content = "\tMáy Lạnh : <$ID> <loại máy lạnh : 1 chiều> "+super.toStringValue();
    if(hasInverter)
      {
        content+="\n\tInverter: <Có>";
      }
    else{
      content+="\n\tInverter: <Không>";
    }
    return content;
  }
  @override
  void  enterData(){
    super.enterData();
    switch (enterString("\t\t\t\t\t\tInverter : 1.Có\t2.Không :")) {
      case "1":
        hasInverter = true;
        break;
      case "2":
        hasInverter = false;
        break;
    }
    price = getOneWayAirConditionePrice(hasInverter);
  }



}
