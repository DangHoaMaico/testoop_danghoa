import 'dart:core';
import 'dart:io';
import 'package:testoop_danghoa/Calculate.dart' as testoop_danghoa;
import 'package:testoop_danghoa/EnterData.dart';
import '../model/AirConditioner/OneWayAirConditione.dart';
import '../model/AirConditioner/TwoWayAirConditione.dart';
import '../model/Bill_Infomation.dart';
import '../model/Bill.dart';
import '../model/Customer.dart';
import '../model/Fan/Standard_Fan.dart';
import '../model/Fan/Rechargeable_Fan.dart';
import '../model/Fan/Steam_Fan.dart';
import 'FileStorage.dart';

int? n = 0;
List<HoaDon> listHoaDon = [];
FileStorage fileStorage  = FileStorage();

Future<void> main(List<String> arguments) async {
  Menu();
}

void Menu(){
  print("\t---- Menu ----");
  print("\t1. Thêm Hóa Đơn Mới");
  print("\t2. Xem danh sách hóa đơn");
  print("\t3. Thoát");
  switch(enterString("\t\tLựa chọn : "))
  {
    case "1":
      ThemHoaDon();
      break;
    case "2":
      HienThiDanhSachHoaDon();
      break;
    case "3":
      exit(0);
    default:
      print( "\tVui lòng chọn đúng lựa chọn!\n\tNhấn phím bất kì để tiếp tục");
      stdin.readLineSync();
      print( "\x1B[2J\x1B[0;0H");
      Menu();
      break;
  }
}


Future<void> ThemHoaDon() async {
  n = enterNum("\t\tSố lượng hóa đơn muốn nhập: ") as int?;
  if (n != null) {
    for (int i = 0; i < n!; i++) {
      //Thông tin hóa đơn
      String? maHoaDon;
      KhachHang khachHang = KhachHang.noParameter();
      List<ChiTietHoaDon> listChiTietHoaDon = [];
      DateTime ngayLapHoaDon;
      num giaHoaDon =0;
      //Nhập thông tin hóa đơn
      print("\t\tNhập thông tin hóa đơn ${i + 1}: ");
      maHoaDon = enterString("\t\tMã hóa đơn: ");
      ngayLapHoaDon = DateTime.now();
      stdout.writeln("\t\tNgày lập hóa đơn: " + testoop_danghoa.ToStringDate(ngayLapHoaDon));

      //Nhập thông tin khách hàng
      print("\t\tThông tin khách hàng:");
      khachHang.enterData();

      stdout.writeln("\t\t\tNhập danh sách các chi tiết hóa đơn:");
      int? soCTHoaDon = enterNum("\t\t\t\tSố lượng chi tiết trong danh sách các chi tiết hóa đơn: ") as int?;

      for (int j = 0; j < soCTHoaDon!; j++) {
        print("\t\t\t\tNhập chi tiết hóa đơn thứ ${j + 1}");
        String? loaiThietBi = enterString("\t\t\t\t\tChọn loại thiết bị điện (1-máy quạt, 2- máy lạnh) , Phím khác - Hủy:");
        switch (loaiThietBi) {
          case "1":
            String? loaiQuat = enterString("\t\t\t\t\t\tChọn loại máy quạt (1-máy quạt đứng,2- máy quạt hơi nước,3 – máy quạt sạc điện) , Phím khác - Hủy:");
            //Chọn và Nhập thông tin máy quạt
            switch (loaiQuat) {
              case "1":
                Standard_Fan thietBiDien = Standard_Fan.noParameter();
                thietBiDien.enterData();
                ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(thietBiDien,  enterNum("\t\t\t\tSố lượng bán ra: ")as int);
                listChiTietHoaDon.add(chiTietHoaDon);
                break;
              case "2":
                Steam_Fan thietBiDien = Steam_Fan.noParameter(0);
                thietBiDien.enterData();
                ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(thietBiDien,  enterNum("\t\t\t\tSố lượng bán ra: ")as int);
                listChiTietHoaDon.add(chiTietHoaDon);
                break;
              case "3":
                Rechargeable_Fan thietBiDien = Rechargeable_Fan.noParameter(0);
                thietBiDien.enterData();
                ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(thietBiDien,  enterNum("\t\t\t\tSố lượng bán ra: ")as int);
                listChiTietHoaDon.add(chiTietHoaDon);
                break;
              default:
                break;
            }
            break;

          case "2":
          //Chọn và Nhập thông tin máy lạnh
            String? loaiMayLanh = enterString("\t\t\t\t\t\tChọn loại máy lạnh (1-máy lạnh 1 chiều,2-máy lạnh 2 chiều) , Phím khác - Hủy:");
            switch (loaiMayLanh) {
              case "1":
                OneWayAirConditioner mayLanh1Chieu =  OneWayAirConditioner.noParameter();
                mayLanh1Chieu.enterData();
                ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(mayLanh1Chieu,  enterNum("\t\t\t\tSố lượng bán ra: ")as int);
                listChiTietHoaDon.add(chiTietHoaDon);
                break;
              case "2":
                TwoWayAirConditioner mayLanh2Chieu =  TwoWayAirConditioner.noParameter(false,false);
                mayLanh2Chieu.enterData();
                ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon(mayLanh2Chieu,  enterNum("\t\t\t\tSố lượng bán ra: ")as int);
                listChiTietHoaDon.add(chiTietHoaDon);
                break;
              default:
                break;
            }
            break;
          default:
            break;
        }
      }

      //Tính tổng giá hóa đơn
      for (var element in listChiTietHoaDon) { giaHoaDon += (element.thietBiDien.price!*element.soLuong);}
      HoaDon hoaDon = HoaDon(maHoaDon!, khachHang, listChiTietHoaDon, ngayLapHoaDon,giaHoaDon );

      if(hoaDon.listChiTietHoaDon.isNotEmpty)
        {
          print("\t\tTổng giá Hóa Đơn: "+ hoaDon.giaHoaDon.toString());
          listHoaDon.add(hoaDon);
          await fileStorage.writeHoaDon(hoaDon);
        }
      else{
        print(" Đã hủy! nhấn phím bất kì để quay về Menu chính");
        stdin.readLineSync();
      }

      print( "\x1B[2J\x1B[0;0H");
      Menu();
    }
  }
}

Future<void> HienThiDanhSachHoaDon() async {
  stdin.echoMode = false;
  stdin.lineMode = false;
  //trang đầu tiên là Hóa đon 0
  int page =0;
  //lấy danh sách hóa đơn
  List<String> hoaDons = fileStorage.getDanhSachHoaDon();
  //Hiển thị hóa đơn đầu tiên
  fileStorage.readHoaDon(page,hoaDons);

  while(true){
   var value =  stdin.readByteSync();
   switch(value)
   {
     case 110://nhấn Phím N
       if(page < (fileStorage.getDanhSachHoaDon().length-1) )
       {
         fileStorage.readHoaDon(++page,hoaDons);
       }
       else{
         page =0;
         fileStorage.readHoaDon(page,hoaDons);
       }
       break;
     case 112://nhấn Phím P
       if(page>0)
       {
         fileStorage.readHoaDon(--page,hoaDons);
       }
       else{
         page =0;
         fileStorage.readHoaDon(page,hoaDons);
       }
       break;
     default:
       //clean màn hình và setting lại stdin
       stdin.lineMode = true;
       stdin.echoMode = true;
       print( "\x1B[2J\x1B[0;0H");
       Menu();
       break;
   }
  }
}





