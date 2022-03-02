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
  return res;
}
String? enterAdress (String label)
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
      if(res.length<12){
        stdout.write("\t\tVui lòng nhập địa chỉ chi tiết (nhiều hơn 12 kí tự) \n");
        return enterAdress(label);
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

String? enterPhone(String label) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String? res ;
  stdout.write(label);
  res =  stdin.readLineSync(encoding: utf8) ;
  RegExp regExp = RegExp(patttern);
  if(res!=null)
    {
      if (res.isEmpty) {
        stdout.write("\t\tVui lòng không để trống! \n");
        enterPhone(label);
      }
      else if (!regExp.hasMatch(res)) {
        stdout.write("\t\tVui lòng số điện thoại đúng \n");
        enterPhone(label);
      }
    }
  return res;
}
