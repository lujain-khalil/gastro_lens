import 'package:flutter/material.dart';
import 'package:gastro_lens/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';
import 'models/providers.dart';
import 'themes/color_schemes.g.dart';
import 'themes/text_theme_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NavProvider()),
        ChangeNotifierProvider(
          create: (context) {
            var provider = UploadsProvider();
            provider.loadUploads();
            return provider;
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'GastroLens',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              textTheme: TextThemeColor.nullFontColor(GoogleFonts.workSansTextTheme()),
              primaryTextTheme: TextThemeColor.nullFontColor(GoogleFonts.workSansTextTheme()),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              textTheme: TextThemeColor.nullFontColor(GoogleFonts.workSansTextTheme()),
              primaryTextTheme: TextThemeColor.nullFontColor(GoogleFonts.workSansTextTheme()),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: const MainScreen(),
          );
        }
      ),
    );
  }
}