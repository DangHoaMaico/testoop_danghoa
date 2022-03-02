import 'package:testoop_danghoa/Calculate.dart';

import 'BillInfomation.dart';
import 'Customer.dart';

class Bill{
  String iD;
  Customer customer;
  List<BIllInfomation>listBillInfo ;
  DateTime createdDate;
  num totalPrice;

  Bill(this.iD, this.customer, this.listBillInfo,
      this.createdDate, this.totalPrice);
  String ToString(){
    return "Hóa đơn: \tMã hóa đơn : <$iD> \tNgày lâp: <${toStringDate(createdDate)}> \tTổng tiền: <$totalPrice>";
  }
}