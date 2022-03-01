import 'package:intl/intl.dart';

num getStandardFanPrice(){
  return 500;
}

num getSteamFanPrice(num dungTich){
  return dungTich * 400;
}


num getRechargeableFanPrice(num dungLuongPin){
  return dungLuongPin * 500;
}


num getOneWayAirConditionePrice(bool hasInverter){
  return hasInverter? 1500:1000;
}


num getTwoWayAirConditionerPrice(bool hasInverter,bool khangKhuan,bool khuMui){
  num price = 0;

  if(hasInverter)
    {
      price =2500;
    }
  else{
    price = 2000;
  }

  if(khangKhuan)
    {
      price+=500;
    }

  if(khuMui)
  {
    price+=500;
  }
  return price;
}
String ToStringDate(DateTime dateTime){
  var formatter = DateFormat('dd/MM/yyyy');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}
