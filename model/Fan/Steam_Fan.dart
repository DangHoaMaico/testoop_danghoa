import 'package:testoop_danghoa/Calculate.dart';
import 'package:testoop_danghoa/EnterData.dart';

import 'Fan.dart';

class Steam_Fan extends Fan{
  num liter ;
  Steam_Fan(String ID, String productName, num? price, String whereProduction,this.liter) : super(ID, productName, price, whereProduction);
  Steam_Fan.noParameter(this.liter):super('', '', 0, '');
  @override
  String toStringValue() {

    String content = "\tMáy Quạt : <$ID> <Loại máy quạt : Máy quạt hơi nước> "+super.toStringValue()+"\tDung tích tối đa: <$liter l>";

    return content;
  }
  @override
  void  enterData(){
    super.enterData();
    liter = enterNum("\t\t\t\t\t\tDung tích nước: ")!;
    price = getSteamFanPrice(liter);
  }
}