import 'package:chat_component/chat_components/view/widgets/log_print/log_print_condition.dart';
import 'package:intl/intl.dart';

class DateTimeConvertor {
 static String timeExt(String time){
    return DateFormat("hh:mm a").format(DateTime.parse(time).toLocal()).toString();
  }
  static String dateTimeConvertor(String time){
    return DateFormat("MMMMd HH:mm a").format(DateTime.parse(time).toLocal()).toString();
  }
  static DateTime dateTimeExt(String time){
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
  }
  static String dateConvertor(String time){
    return DateFormat("yyyy-MM-dd").format(DateTime.parse(time).toLocal()).toString();
  }
  static String dateConvertorDate(String time){
    return DateFormat("dd MMMM, yy").format(DateTime.parse(time).toLocal()).toString();
  }

  static String formattedTime({required int timeInSecond}) {
   int sec = timeInSecond % 60;
   int min = (timeInSecond / 60).floor();
   String minute = min.toString().length <= 1 ? "0$min" : "$min";
   String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
   return "$minute : $second";
 }

 static String dateTimeShow(String time) {
   String dateTime = dateTimeConvertor(time);
   if (DateTime.now().toUtc().difference(DateTime.parse(time)).inDays < 1) {
     return 'Today ${timeExt(time)}';
   }
   else if(DateTime.now().toUtc().difference(DateTime.parse(time)).inDays == 1){
     return 'Yesterday';
   }
   return dateTime;
 }

 static DateTime dateTimeConvExt(String time) {
   return DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
 }

 static String dateTimeShowMessages(String time) {
   logPrint(time);
   DateTime ?newDate;
   try{
     newDate= DateTime.parse(time);
   }catch(e){
     logPrint("sdfnsegfjln$e");
   }

   String dateTime = dateConvertorDate(time);
   logPrint("wsefdg${dateTime}");
   if (DateTime.now().day == DateTime.parse(time).day) {
     return 'Today';
   }
   else if(DateTime.now().toUtc().difference(DateTime.parse(time)).inDays == 1){
     return 'Yesterday';
   }
   return dateTime;
 }
}