import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:testoop_danghoa/Calculate.dart' as testoop_danghoa;
import 'package:testoop_danghoa/EnterData.dart';
import '../model/AirConditioner/OneWayAirConditioner/OneWayAirConditione.dart';
import '../model/AirConditioner/TwoWayAirConditioner/TwoWayAirConditione.dart';
import '../model/Bill/Bill.dart';
import '../model/Bill/BillInfomation/BillInfomation.dart';
import '../model/Customer/Customer.dart';
import '../model/Fan/StandardFan/StandardFan.dart';
import '../model/Fan/RechargeableFan/RechargeableFan.dart';
import '../model/Fan/SteamFan/SteamFan.dart';
import 'FileStorage.dart';

int? n = 0;
List<Bill> listBill = [];
FileStorage fileStorage = FileStorage();
List<Bill> temp = [];
Future<void> main(List<String> arguments) async {
  try {
    fileStorage = FileStorage();
    menu();
  } catch (e) {
    print(e.toString());
  }
}

Future<void> menu() async {
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
          await  fileStorage.saveListBill(listBill).whenComplete(() => {
              clearAndGotoMenuWithLabel(
                  "\tLưu thành công với đường dẫn ${fileStorage.path}\n\t Nhấn phím bất kì để tiếp tục !")}).catchError((e)=>{print(e.toString())});
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
      clearAndGotoMenuWithLabel("\tVui lòng chọn đúng lựa chọn!\n\tNhấn phím bất kì để tiếp tục");
      break;
  }
}

Future<void> addBill() async {
  print("\t\tLưu ý : Nhấn E + Enter để hủy hóa đơn");
  n = enterNumAndCallFunction("\t\tSố lượng hóa đơn muốn nhập: ",menu) as int?;
  if (n != null) {
    for (int i = 0; i < n!; i++) {
      //Thông tin hóa đơn
      String? idBill;
      Customer customer = Customer.noParameter();
      List<BillInfomation> listChiTietHoaDon = [];
      DateTime createdDate;
      num totalPrice = 0;
      //Nhập thông tin hóa đơn
      print("\t\tNhập thông tin hóa đơn ${i + 1}: ");
      idBill = enterStringAndCallFunction("\t\tMã hóa đơn: ",menu);
      createdDate = DateTime.now();
      stdout.writeln(
          "\t\tNgày lập hóa đơn: " + testoop_danghoa.toStringDate(createdDate));
      //Nhập thông tin khách hàng
      print("\t\tThông tin khách hàng:");
      customer.enterData();
      stdout.writeln("\t\t\tNhập danh sách các chi tiết hóa đơn:");
      int? soCTHoaDon = enterNumAndCallFunction(
              "\t\t\t\tSố lượng chi tiết trong danh sách các chi tiết hóa đơn: ",menu)
          as int?;
      for (int j = 0; j < soCTHoaDon!; j++) {
        print("\t\t\t\tNhập chi tiết hóa đơn thứ ${j + 1}");
        String? deviceType = enterStringWithCondition(
            "\t\t\t\t\tChọn loại thiết bị điện (1-máy quạt, 2- máy lạnh) :  ",["1","2"]);
        switch (deviceType) {
          case "1":
            String? fanType = enterStringWithCondition(
                "\t\t\t\t\t\tChọn loại máy quạt (1-máy quạt đứng,2- máy quạt hơi nước,3 – máy quạt sạc điện): ",["1","2","3"]);
            //Chọn và Nhập thông tin máy quạt
            switch (fanType) {
              case "1":
                StandardFan standardFan = StandardFan.noParameter();
                standardFan.enterData();
                BillInfomation billInfo = BillInfomation(
                    standardFan, enterNumAndCallFunction("\t\t\t\tSố lượng bán ra: ",menu) as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "2":
                SteamFan steamFan = SteamFan.noParameter(0);
                steamFan.enterData();
                BillInfomation billInfo = BillInfomation(
                    steamFan, enterNumAndCallFunction("\t\t\t\tSố lượng bán ra: ",menu) as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "3":
                RechargeableFan rechargeableFan =
                    RechargeableFan.noParameter(0);
                rechargeableFan.enterData();
                BillInfomation billInfo = BillInfomation(rechargeableFan,
                    enterNumAndCallFunction("\t\t\t\tSố lượng bán ra: ",menu) as int);
                listChiTietHoaDon.add(billInfo);
                break;
            }
            break;

          case "2":
            //Chọn và Nhập thông tin máy lạnh
            String? loaiMayLanh = enterStringWithCondition(
                "\t\t\t\t\t\tChọn loại máy lạnh (1-máy lạnh 1 chiều,2-máy lạnh 2 chiều): ",["1","2"]);
            switch (loaiMayLanh) {
              case "1":
                OneWayAirConditioner oneWayConditioner =
                    OneWayAirConditioner.noParameter();
                oneWayConditioner.enterData();
                BillInfomation billInfo = BillInfomation(oneWayConditioner,
                    enterNumAndCallFunction("\t\t\t\tSố lượng bán ra: ",menu) as int);
                listChiTietHoaDon.add(billInfo);
                break;
              case "2":
                TwoWayAirConditioner twoWayConditioner =
                    TwoWayAirConditioner.noParameter(false, false);
                twoWayConditioner.enterData();
                BillInfomation billInfo = BillInfomation(twoWayConditioner,
                    enterNumAndCallFunction("\t\t\t\tSố lượng bán ra: ",menu)as int);
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
        totalPrice += (element.electricalEquipment.price! * element.amount);
      }
      Bill bill =
          Bill(idBill!, customer, listChiTietHoaDon, createdDate, totalPrice);
      if (bill.listBillInfo.isNotEmpty) {
        print("\tTổng Tiền hóa đơn : $totalPrice");
        listBill.add(bill);
        temp.add(bill);
        print("\tĐã lưu vào bộ nhớ tạm\n");
      }
    }
    clearAndGotoMenuWithLabel("\tNhấn phím bất kì để quay về Menu");
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
          break;
      }
      menu();
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
    readBillInCache(0, temp);
    while (true) {
      var value = stdin.readByteSync();
      switch (value) {
        case 110: //nhấn Phím N
          if (page < (temp.length - 1)) {
            readBillInCache(++page, temp);
          } else {
            page = 0;
            readBillInCache(page, temp);
          }
          break;
        case 112: //nhấn Phím P
          if (page > 0) {
            readBillInCache(--page, temp);
          } else {
            page = 0;
            readBillInCache(page, temp);
          }
          break;
        default:
          temp.clear();
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
    clearAndGotoMenuWithLabel("\t   Bạn chưa có hóa đơn nào cả !\n\tNhấn phím bất kì để quay lại Menu");
  }
}

Future<void> readBillInCache(int page, List<Bill> array) async {
  //Nhân màn hình và di chuyển con trỏ về dòng đầu
  Bill bill = array[page];
  print("\x1B[1J\x1B[0;0H");
  print("\t\t\t\t\tThông tin hóa đơn");
  String value = "\t\t${bill.ToString()}\n\n"
      "\t${bill.customer.toStringValue()}\n\n"
      "\tDanh sách các chi tiết hóa đơn:\n\n";
  for (var element in bill.listBillInfo) {
    value += element.electricalEquipment.toStringValue() +
        "\tSố lượng : ${element.amount}\n\n";
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
