// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

class DropLanguageLocale extends StatefulWidget {
  const DropLanguageLocale({Key? key}) : super(key: key);
  
  @override
  State<DropLanguageLocale> createState() => _DropLanguageLocaleState();
}

class _DropLanguageLocaleState extends State<DropLanguageLocale> {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: context.locale,
          items: context.supportedLocales.map(( Locale locale) => DropdownMenuItem<Locale>( 
            value: locale, 
            child:Text(locale.languageCode, style: const TextStyle(fontSize: 11.0)),   
          )).toList(),
          onChanged: (Locale? newLocale) async{
            await context.setLocale(Locale(newLocale!.languageCode, newLocale.countryCode));
                  
          }
        )
      )
    );
  }

}
