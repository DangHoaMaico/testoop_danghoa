import 'package:testoop_danghoa/Calculate.dart';
import 'package:testoop_danghoa/EnterData.dart';

import 'Fan.dart';

class SteamFan extends Fan{
  num liter ;
  SteamFan(String iD, String productName, num? price, String whereProduction,this.liter) : super(iD, productName, price, whereProduction);
  SteamFan.noParameter(this.liter):super('', '', 0, '');
  @override
  String toStringValue() {
    String content = "\tMáy Quạt : <$iD> <Loại máy quạt : Máy quạt hơi nước> "+super.toStringValue()+"\tDung tích tối đa: <$liter l>";
    return content;
  }
  @override
  void  enterData(){
    super.enterData();
    liter = enterNum("\t\t\t\t\t\tDung tích nước: ")!;
    price = getSteamFanPrice(liter);
  }
}