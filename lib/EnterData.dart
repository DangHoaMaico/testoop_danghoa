import 'dart:convert';
import 'dart:io';

String? enterString (String label)
{
  stdout.write(label);
  String? res = "";
  res =  stdin.readLineSync(encoding: utf8);
  if(res!=null)
    {
      if(res.isEmpty){
        stdout.write("\t\tVui lòng không để trống! \n");
        return enterString(label);
      }
    }
  return res?.trim();
}
String? enterStringAndCallFunction (String label,void Function() function)
{
  stdout.write(label);
  String? res = "";
  res =  stdin.readLineSync(encoding: utf8);
  if(res == "E")
    {
      print("\t\tĐã hủy hóa đơn! Nhấn phím bất kì để quay lại Menu ");
      stdin.readLineSync();
      print("\x1B[2J\x1B[0;0H");
      function();
    }
  else{
    if(res!=null)
    {
      if(res.isEmpty){
        stdout.write("\t\tVui lòng không để trống! \n");
        return enterString(label);
      }
    }
  }
  return res?.trim();
}
String? enterStringWithCondition (String label,List<String>array)
{
  stdout.write(label);
  String? res = "";
  res =  stdin.readLineSync(encoding: utf8);
  if(res!=null)
  {
    if(res.isEmpty){
      stdout.write("\t\tVui lòng không để trống! \n");
      return enterString(label);
    }
    else{
      if(!array.contains(res.trim())){
        stdout.write("\t\tVui lòng chọn đúng giá trị! \n");
        return enterStringWithCondition(label,array);
      }
    }
  }
  return res?.trim();
}
String? enterAdress (String label,void Function() function)
{
  stdout.write(label);
  String? res = "";
  res =  stdin.readLineSync(encoding: utf8);
  if(res!=null)
  {
    if(res.isEmpty){
      stdout.write("\t\tVui lòng không để trống! \n");
      return enterAdress(label,function);
    }
    else{
      if(res=="E"){
        print("\t\tĐã hủy hóa đơn! Nhấn phím bất kì để quay lại Menu ");
        stdin.readLineSync();
        print("\x1B[2J\x1B[0;0H");
        function();
      }
      else{
        if(res.length<12){
          stdout.write("\t\tVui lòng nhập địa chỉ chi tiết (nhiều hơn 12 kí tự) \n");
          return enterAdress(label,function);
        }
      }
    }
  }
  return res;
}
num? enterNum (String label)
{
  stdout.write(label);
  num? res ;
  res =  int.tryParse(stdin.readLineSync(encoding: utf8)!) ;
  if(res==null)
  {
      stdout.write("\t\tVui lòng nhập số ! \n");
      return enterNum(label);
  }
  else{
    if(res<0||res ==0)
      {
        stdout.write("\t\tVui lòng nhập số lớn hơn 0 ! \n");
        return enterNum(label);
      }
  }
  return res;
}
num? enterNumAndCallFunction (String label,void Function() function)
{
  stdout.write(label);
  num? res ;
  String? str = stdin.readLineSync(encoding: utf8);
  if(str!=null)
    {
      if(str.isEmpty)
        {
          stdout.write("\t\tVui lòng không để trống! \n");
          return enterNumAndCallFunction(label,function);
        }
      else{
        if(str=="E"){
          print("\t\tĐã hủy hóa đơn! Nhấn phím bất kì để quay lại Menu ");
          stdin.readLineSync();
          print("\x1B[2J\x1B[0;0H");
          function();
        }
        else{
          res =  int.tryParse(str) ;
          if(res==null)
          {
            stdout.write("\t\tVui lòng nhập số ! \n");
            return enterNumAndCallFunction(label,function);
          }
          else{
            if(res<0||res ==0)
            {
              stdout.write("\t\tVui lòng nhập số lớn hơn 0 ! \n");
              return enterNumAndCallFunction(label,function);
            }
          }
        }
      }

    }

  return res;
}

String? enterPhone(String label,void Function() function) {
  String patttern = r'(^(?:[+0]9)?[0-9]{9,10}$)';
  String? res ;
  stdout.write(label);
  res =  stdin.readLineSync(encoding: utf8) ;
  RegExp regExp = RegExp(patttern);
  if(res!=null)
    {
      if (res.isEmpty) {
        stdout.write("\t\tVui lòng không để trống! \n");
        enterPhone(label,function);
      }
      else {
        if(res =="E"){
          print("\t\tĐã hủy hóa đơn! Nhấn phím bất kì để quay lại Menu ");
          stdin.readLineSync();
          print("\x1B[2J\x1B[0;0H");
          function();
        }
        else{
          if (!regExp.hasMatch(res))
          {
            stdout.write("\t\tVui lòng số điện thoại đúng \n");
            enterPhone(label,function);
          }
        }
      }
    }
  return res;
}
