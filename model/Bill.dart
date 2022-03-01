import 'package:testoop_danghoa/Calculate.dart';

import 'Bill_Infomation.dart';
import 'Customer.dart';

class HoaDon{
  String maHoaDon;
  KhachHang khachHang;
  List<ChiTietHoaDon>listChiTietHoaDon ;
  DateTime ngayLapHoaDon;
  num giaHoaDon;

  HoaDon(this.maHoaDon, this.khachHang, this.listChiTietHoaDon,
      this.ngayLapHoaDon, this.giaHoaDon);
  String ToString(){
    return "Hóa đơn: \tMã hóa đơn : <$maHoaDon> \tNgày lâp: <${ToStringDate(ngayLapHoaDon)}> \tTổng tiền: <$giaHoaDon>";
  }
}