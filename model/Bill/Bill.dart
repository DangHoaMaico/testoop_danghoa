import 'package:testoop_danghoa/Calculate.dart';

import '../Customer/Customer.dart';
import 'BillInfomation/BillInfomation.dart';


class Bill{
  String iD;
  Customer customer;
  List<BillInfomation>listBillInfo ;
  DateTime createdDate;
  num totalPrice;

  Bill(this.iD, this.customer, this.listBillInfo,
      this.createdDate, this.totalPrice);
  String ToString(){
    return "Hóa đơn: \tMã hóa đơn : $iD \tNgày lâp: ${toStringDate(createdDate)} \tTổng tiền: $totalPrice";
  }
}