import 'dart:developer';
import 'package:flutter/foundation.dart';

void logPrint(var message){
  if (kDebugMode) {
    log(message.toString());
  }
}