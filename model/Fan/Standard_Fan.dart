import 'package:testoop_danghoa/Calculate.dart';

import 'Fan.dart';

class Standard_Fan extends Fan {
  Standard_Fan(String iD, String productName, num? price, String whereProduction) : super(iD, productName, price, whereProduction);
  Standard_Fan.noParameter():super('', '', 0, '');
  @override
  String toStringValue() {
    String content = "\tMáy Quạt : <$iD> <Loại máy quạt : Máy quạt đứng> "+super.toStringValue();
    return content;
  }
  @override
  void  enterData(){
    super.enterData();
    price = getStandardFanPrice();
  }
}
