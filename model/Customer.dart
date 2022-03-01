import 'package:testoop_danghoa/EnterData.dart';

class KhachHang{
  late String maKhachHang;
  late String tenKhachHang;
  late String diaChi;
  late String soDienThoai;
  KhachHang(this.maKhachHang,this.tenKhachHang,this.diaChi,this.soDienThoai);
  KhachHang.noParameter();
  String toStringValue(){
    return "Thông tin khác hàng: \tMã khách hàng: <$maKhachHang> \tTên Khách Hàng: <$tenKhachHang> \tĐịa Chỉ: <$diaChi> \tSố điện thoại: <$soDienThoai>";
  }
  void enterData(){
    //Nhập thông tin khách hàng
    maKhachHang = enterString("\t\t\tMã khách hàng: ")!;
    tenKhachHang = enterString("\t\t\tTên khách hàng: ")!;
    diaChi = enterAdress("\t\t\tĐịa chỉ:  ")!;
    soDienThoai = enterPhone("\t\t\tSố điện thoại:  ")!;
  }
}