import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:testoop_danghoa/Calculate.dart' as testoop_danghoa;
import 'package:testoop_danghoa/EnterData.dart';
import '../model/AirConditioner/OneWayAirConditione.dart';
import '../model/AirConditioner/TwoWayAirConditione.dart';
import '../model/BillInfomation.dart';
import '../model/Bill.dart';
import '../model/Customer.dart';
import '../model/Fan/StandardFan.dart';
import '../model/Fan/RechargeableFan.dart';
import '../model/Fan/SteamFan.dart';
import 'FileStorage.dart';

int? n = 0;
List<Bill> listBill = [];
FileStorage fileStorage = FileStorage();

Future<void> main(List<String> arguments) async {
  try {
    fileStorage = FileStorage();
    menu();
  } catch (e) {
    print(e.toString());
  }
}

void menu() {
  print("\t---- Menu ----");
  print("\t1. Thêm Hóa Đơn Mới");
  print("\t2. Xem danh sách hóa đơn từ bộ nhớ");
  print("\t3. Xem hóa đơn vừa tạo");
  print("\t4. Lưu hóa đơn vừa tạo vào bộ nhớ");
  print("\t5. Thoát");
  switch (enterString("\t\tLựa chọn : ")) {
    case "1":
      addBill();
      break;
    case "2":
      displayListBill();
      break;
    case "3":
      displayListBillInCache();
      break;
    case "4":
      if (listBill.isNotEmpty) {
        fileStorage.saveListBill(listBill).whenComplete(() => {
              clearAndGotoMenuWithLabel(
                  "Lưu thành công với đường dẫn ${fileStorage.path}\n\t Nhấn phím bất kì để tiếp tục !")
            });
        listBill.clear();
      } else {
        clearAndGotoMenuWithLabel(
            "\tVui lòng tạo hóa đơn mới và sau đó hãy bắt đầu lưu!");
      }
      break;
    case "5":
      if (listBill.isNotEmpty) {
        switch (enterString(
            "\t Vẫn còn hóa đơn chưa lưu vào bộ nhớ ! \n\t 1. Thoát và không lưu \t2.Thoát và lưu \tPhím khác: Quay về Menu")) {
          case "1":
            exit(0);
          case "2":
            fileStorage.saveListBill(listBill).whenComplete(() => {
                  exitWithLabel(
                      "\tLưu thành công với đường dẫn ${fileStorage.path}\n\t Nhấn phím bất kì để thoát !"),
                  listBill.clear()
                });
            break;
          default:
            clearAndGotoMenu();
            break;
        }
      } else {
        exit(0);
      }
      break;
    default:
      clearAndGotoMenuWithLabel(
          "\tVui lòng chọn đúng lựa chọn!\n\tNhấn phím bất kì để tiếp tục");
      break;
  }
}

Future<void> addBill() async {
  n = enterNum("\t\tSố lượng hóa đơn muốn nhập: ") as int?;
  if (n != null) {
    for (int i = 0; i < n!; i++) {
      //Thông tin hóa đơn
      String? idBill;
      Customer customer = Customer.noParameter();
      List<BIllInfomation> listChiTietHoaDon = [];
      DateTime createdDate;
      num giaHoaDon = 0;
      //Nhập thông tin hóa đơn
      print("\t\tNhập thông tin hóa đơn ${i + 1}: ");
      idBill = enterString("\t\tMã hóa đơn: ");
      createdDate = DateTime.now();
      stdout.writeln(
          "\t\tNgày lập hóa đơn: " + testoop_danghoa.toStringDate(createdDate));

      //Nhập thông tin khách hàng
      print("\t\tThông tin khách hàng:");
      customer.enterData();

      stdout.writeln("\t\t\tNhập danh sách các chi tiết hóa đơn:");
      int? soCTHoaDon = enterNum(
              "\t\t\t\tSố lượng chi tiết trong danh sách các chi tiết hóa đơn: ")
          as int?;

      for (int j = 0; j < soCTHoaDon!; j++) {
        print("\t\t\t\tNhập chi tiết hóa đơn thứ ${j + 1}");
        String? deviceType = enterString(
            "\t\t\t\t\tChọn loại thiết bị điện (1-máy quạt, 2- máy lạnh) , Phím khác - Hủy:");
        switch (deviceType) {
          case "1":
            String? fanType = enterString(
                "\t\t\t\t\t\tChọn loại máy quạt (1-máy quạt đứng,2- máy quạt hơi nước,3 – máy quạt sạc điện) , Phím khác - Hủy:");
            //Chọn và Nhập thông tin máy quạt
            switch (fanType) {
              case "1":
                StandardFan standardFan = StandardFan.noParameter();
                standardFan.enterData();
                BIllInfomation billInfo = BIllInfomation(
                    standardFan, enterNum("\t\t\t\tSố lượng bán ra: ") as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "2":
                SteamFan steamFan = SteamFan.noParameter(0);
                steamFan.enterData();
                BIllInfomation billInfo = BIllInfomation(
                    steamFan, enterNum("\t\t\t\tSố lượng bán ra: ") as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "3":
                RechargeableFan rechargeableFan =
                    RechargeableFan.noParameter(0);
                rechargeableFan.enterData();
                BIllInfomation billInfo = BIllInfomation(rechargeableFan,
                    enterNum("\t\t\t\tSố lượng bán ra: ") as int);
                listChiTietHoaDon.add(billInfo);
                break;
              default:
                break;
            }
            break;

          case "2":
            //Chọn và Nhập thông tin máy lạnh
            String? loaiMayLanh = enterString(
                "\t\t\t\t\t\tChọn loại máy lạnh (1-máy lạnh 1 chiều,2-máy lạnh 2 chiều) , Phím khác - Hủy:");
            switch (loaiMayLanh) {
              case "1":
                OneWayAirConditioner oneWayConditioner =
                    OneWayAirConditioner.noParameter();
                oneWayConditioner.enterData();
                BIllInfomation billInfo = BIllInfomation(oneWayConditioner,
                    enterNum("\t\t\t\tSố lượng bán ra: ") as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "2":
                TwoWayAirConditioner twoWayConditioner =
                    TwoWayAirConditioner.noParameter(false, false);
                twoWayConditioner.enterData();
                BIllInfomation billInfo = BIllInfomation(twoWayConditioner,
                    enterNum("\t\t\t\tSố lượng bán ra: ") as int);
                listChiTietHoaDon.add(billInfo);
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
      for (var element in listChiTietHoaDon) {
        giaHoaDon += (element.electricalEquipment.price! * element.amount);
      }
      Bill hoaDon =
          Bill(idBill!, customer, listChiTietHoaDon, createdDate, giaHoaDon);

      if (hoaDon.listBillInfo.isNotEmpty) {
        print("\tTổng Tiền hòa đơn : $giaHoaDon");
        listBill.add(hoaDon);
        print("\tĐã lưu vào bộ nhớ tạm");
        print("\tNhấn phím bất kì để quay về Menu chính ");
        stdin.readLineSync();
      } else {
        print(" Đã hủy! nhấn phím bất kì để quay về Menu chính");
        stdin.readLineSync();
      }
      clearAndGotoMenu();
    }
  }
}

Future<void> displayListBill() async {
  stdin.echoMode = false;
  stdin.lineMode = false;
  //trang đầu tiên là Hóa đon 0
  int page = 0;
  //lấy danh sách hóa đơn
  List<String> bills = fileStorage.getListBill();
  if (bills.isNotEmpty) {
    //Hiển thị hóa đơn đầu tiên
    fileStorage.readListBill(page, bills);
    while (true) {
      var value = stdin.readByteSync();
      switch (value) {
        case 110: //nhấn Phím N
          if (page < (fileStorage.getListBill().length - 1)) {
            fileStorage.readListBill(++page, bills);
          } else {
            page = 0;
            fileStorage.readListBill(page, bills);
          }
          break;
        case 112: //nhấn Phím P
          if (page > 0) {
            fileStorage.readListBill(--page, bills);
          } else {
            page = 0;
            fileStorage.readListBill(page, bills);
          }
          break;
        default:
          //clean màn hình và setting lại stdin
          stdin.lineMode = true;
          stdin.echoMode = true;
          print("\x1B[2J\x1B[0;0H");
          menu();
          break;
      }
    }
  } else {
    stdin.lineMode = true;
    stdin.echoMode = true;
    print("\x1B[2J\x1B[0;0H");
    print(
        "\t   Bạn chưa có hóa đơn nào cả !\n\tNhấn phím bất kì để quay lại Menu");
    stdin.readLineSync();
    print("\x1B[2J\x1B[0;0H");
    menu();
  }
}

Future<void> displayListBillInCache() async {
  stdin.echoMode = false;
  stdin.lineMode = false;
  //trang đầu tiên là Hóa đon 0
  int page = 0;
  //lấy danh sách hóa đơn

  if (listBill.isNotEmpty) {
    //Hiển thị hóa đơn đầu tiên
    readBillInCache(0, listBill);
    while (true) {
      var value = stdin.readByteSync();
      switch (value) {
        case 110: //nhấn Phím N
          if (page < (listBill.length - 1)) {
            readBillInCache(page, listBill);
          } else {
            page = 0;
            readBillInCache(page, listBill);
          }
          break;
        case 112: //nhấn Phím P
          if (page > 0) {
            readBillInCache(page, listBill);
          } else {
            page = 0;
            readBillInCache(page, listBill);
          }
          break;
        default:
          //clean màn hình và setting lại stdin
          stdin.lineMode = true;
          stdin.echoMode = true;
          print("\x1B[2J\x1B[0;0H");
          menu();
          break;
      }
    }
  } else {
    stdin.lineMode = true;
    stdin.echoMode = true;
    print("\x1B[2J\x1B[0;0H");
    print(
        "\t   Bạn chưa có hóa đơn nào cả !\n\tNhấn phím bất kì để quay lại Menu");
    stdin.readLineSync();
    print("\x1B[2J\x1B[0;0H");
    menu();
  }
}

Future<void> readBillInCache(int page, List<Bill> array) async {
  //Nhân màn hình và di chuyển con trỏ về dòng đầu
  Bill bill = array[page];
  print("\x1B[1J\x1B[0;0H");
  print("\t\t\t\t\tThông tin hóa đơn");
  String value = "\t\t${bill.ToString()}\n"
      "\t${bill.customer.toStringValue()}\n"
      "\tDanh sách các chi tiết hóa đơn:\n";
  for (var element in bill.listBillInfo) {
    value += element.electricalEquipment.toStringValue() +
        "\tSố lượng : <${element.amount}>\n";
  }
  print(value);
  print("\n\t\t\t\t\tHóa đơn số ${page + 1}/" + array.length.toString());
  print("\t\t\t\t   (P)Previous / Next(N)");
  print("\t\t\t\tNhấn phím bất kì để quay lại ");
}

void clearAndGotoMenu() {
  print("\x1B[2J\x1B[0;0H");
  menu();
}

void clearAndGotoMenuWithLabel(String label) {
  print(label);
  stdin.readLineSync();
  clearAndGotoMenu();
}

void exitWithLabel(String label) {
  print(label);
  stdin.readLineSync();
  exit(0);
}
