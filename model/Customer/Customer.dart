import 'package:testoop_danghoa/EnterData.dart';

import '../../bin/testoop_danghoa.dart';

class Customer{
  late String iD;
  late String name;
  late String address;
  late String soDienThoai;
  Customer(this.iD,this.name,this.address,this.soDienThoai);
  Customer.noParameter();
  String toStringValue(){
    return "Thông tin khách hàng: \tMã khách hàng: $iD \tTên Khách Hàng: $name \n\t\t\t\tĐịa Chỉ: $address \tSố điện thoại: $soDienThoai";
  }
  void enterData(){
    //Nhập thông tin khách hàng
    iD = enterStringAndCallFunction("\t\t\tMã khách hàng: ",menu)!;
    name = enterStringAndCallFunction("\t\t\tTên khách hàng: ",menu)!;
    address = enterAdress("\t\t\tĐịa chỉ:  ",menu)!;
    soDienThoai = enterPhone("\t\t\tSố điện thoại:  ",menu)!;
  }
}