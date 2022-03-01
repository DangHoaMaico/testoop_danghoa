import 'package:testoop_danghoa/Calculate.dart';

import 'BillInfomation.dart';
import 'Customer.dart';

class Bill{
  String ID;
  Customer customer;
  List<BIllInfomation>listBillInfo ;
  DateTime createdDate;
  num totalPrice;

  Bill(this.ID, this.customer, this.listBillInfo,
      this.createdDate, this.totalPrice);
  String ToString(){
    return "Hóa đơn: \tMã hóa đơn : <$ID> \tNgày lâp: <${ToStringDate(createdDate)}> \tTổng tiền: <$totalPrice>";
  }
}