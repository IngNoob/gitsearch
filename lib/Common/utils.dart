import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/app.dart';

  typedef OnExceptionCatch = void Function(String errorMsg);

  showErrorSnackbar(String errorMsg){
    ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(errorMsg, overflow: TextOverflow.clip,), 
        backgroundColor: const Color.fromARGB(255, 143, 8, 8),
        action: SnackBarAction(
          label: 'close'.tr(), 
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(navKey.currentContext!).hideCurrentSnackBar()
        )
      )
    );
  }