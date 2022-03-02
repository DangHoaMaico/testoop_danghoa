import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../model/Bill.dart';
import 'testoop_danghoa.dart';

class FileStorage {
  //Đường dẫn file mới nếu tạo
  String path= Directory.current.path+"/"+"data/data.txt";

  //Đường dẫn của file
  late File file ;
  FileStorage() {
    //Nếu không có đường dẫn của project thì sẽ tạo file mới

      if(FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound)
      {
        file = File(path) ;
      }
      else{
        createNewFile();
    }
  }
  void createNewFile() {
    File(path).createSync(recursive: true);
    file = File(path) ;
  }
  Future<void> writeHoaDon(Bill bill) async {
    String value = "***************************************************\n"
        "\t\t${bill.ToString()}\n"
        "\t${bill.customer.toStringValue()}\n"
        "\tDanh sách các chi tiết hóa đơn:\n";
    for (var element in bill.listBillInfo) {
      value += element.electricalEquipment.toStringValue() +"\tSố lượng : <${element.amount}>\n";
    }
   await file.writeAsString(value,encoding: utf8,mode: FileMode.append);
  }


  Future<void> readListBill(int page,List<String>array) async {
    //Nhân màn hình và di chuyển con trỏ về dòng đầu
    print("\x1B[1J\x1B[0;0H");
    print("\t\t\t\t\tThông tin hóa đơn");
    //TÁCH ĐỂ CHUYỂN QUA DẠNG LIST OBJECT SAU NÀY
    // RegExp exp = RegExp("<(.+?)>");//Tách các Chữ  được kẹp vào <>
    // array.forEach((element) {
    //   List  matches = exp.allMatches(element).map((z) => z.group(0)).toList();
    //   print(matches);
    // });
    print("\t"+array[page]);
    //phân trang
   print("\n\t\t\t\t\tHóa đơn số ${page+1}/"+array.length.toString());
   print("\t\t\t\t   (P)Previous / Next(N)");
   print("\t\t\t\tNhấn phím bất kì để quay lại ");

  }

  Future<void>  saveListBill(List<Bill> bills) async{
    if(bills.isNotEmpty)
    {
    for (Bill element in bills) {
     await writeHoaDon(element);
    }}
    else{
      clearAndGotoMenuWithLabel("\tChưa có hóa đơn mới nào! Vui lòng tạo hóa đơn mới sau đó hãy lưu!\n\t Nhấn phím bất kì để tiếp tục !");
    }

  }
  List<String> getListBill() {
    String value  = file.readAsStringSync(encoding: utf8);
    var array = value.split("***************************************************");
    //Đầu tiên là chuỗi rỗng nên phải remove
    array.removeAt(0);
    return array;
  }
}
