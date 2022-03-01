import 'package:testoop_danghoa/EnterData.dart';

class Customer{
  late String ID;
  late String name;
  late String address;
  late String soDienThoai;
  Customer(this.ID,this.name,this.address,this.soDienThoai);
  Customer.noParameter();
  String toStringValue(){
    return "Thông tin khác hàng: \tMã khách hàng: <$ID> \tTên Khách Hàng: <$name> \tĐịa Chỉ: <$address> \tSố điện thoại: <$soDienThoai>";
  }
  void enterData(){
    //Nhập thông tin khách hàng
    ID = enterString("\t\t\tMã khách hàng: ")!;
    name = enterString("\t\t\tTên khách hàng: ")!;
    address = enterAdress("\t\t\tĐịa chỉ:  ")!;
    soDienThoai = enterPhone("\t\t\tSố điện thoại:  ")!;
  }
}