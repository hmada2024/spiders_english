// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/adjectives_bloc.dart';
import 'package:learn_box_english/blocs/audio_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/blocs/verb_conjugations_bloc.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/database/database_initializer.dart';
import 'package:learn_box_english/screens/home_page.dart';

void main() {
  initializeDatabase(); // Initialize database for Windows
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(),
        ),
        BlocProvider<NounsBloc>(
          create: (context) => NounsBloc(DatabaseHelper()),
        ),
        BlocProvider<AdjectivesBloc>(
          create: (context) => AdjectivesBloc(DatabaseHelper()),
        ),
        BlocProvider<VerbConjugationsBloc>(
          create: (context) => VerbConjugationsBloc(DatabaseHelper()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        primaryColor: AppConstants.primaryColor,
        primaryColorLight: AppConstants.primaryColorLight,
        primaryColorDark: AppConstants.primaryColorDark,
        hintColor: AppConstants.accentColor,
        fontFamily: AppConstants.fontFamily,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppConstants.textColorPrimary),
        ),
        cardTheme: CardTheme(
          color: AppConstants.cardColor,
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppConstants.accentColor,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(error: AppConstants.errorColor),
      ),
      home: const HomePage(), // HomePage is now within the BlocProvider's scope
    );
  }
}
