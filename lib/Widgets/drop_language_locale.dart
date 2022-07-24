import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:provider/provider.dart';

import '../Common/globals.dart';

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
          iconEnabledColor: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
            Theme.of(context).colorScheme.primary : 
            Colors.white,
          items: context.supportedLocales.map(( Locale locale) => DropdownMenuItem<Locale>( 
            value: locale, 
            child: Center(
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(
                  "icons/flags/svg/${Globals.localeFlags[locale.languageCode]}.svg", 
                  package: 'country_icons',  width: 20, height: 20,
                )
              )
            ),
          )).toList(),
          onChanged: (Locale? newLocale) async{
            await context.setLocale(Locale(newLocale!.languageCode, newLocale.countryCode));                  
          }
        )
      )
    );
  }

}
