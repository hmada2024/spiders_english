// constants/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  // App
  static const String appName = 'Spider English';

  // Colors
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color primaryColorLight = Color(0xFFC8E6C9);
  static const Color primaryColorDark = Color(0xFF388E3C);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color textColorPrimary = Color(0xFF212121);
  static const Color textColorSecondary = Color(0xFF757575);
  static const Color backgroundColor = Colors.white;
  static const Color cardColor = Colors.white;

  // Font
  static const String fontFamily = 'Roboto';

  // Database
  static const String databaseName =
      'spiders_english_box.db/spiders_english_box.db';

  // Table Names
  static const String adjectivesTable = 'Adjectives';
  static const String nounsTable = 'nouns';
  static const String verbConjugationsTable = 'verb_conjugations';
  static const String baseWordsTable = 'Base_Words';
  static const String phrasalVerbsTable = 'Phrasal_verbs';
  static const String compoundWordsTable = 'compound_words';
  static const String expressionsIdiomsTable = 'expressions_idioms';
  static const String similarWordsTable = 'similar_words';
  static const String englishSentencesTable = 'english_sentences';
  static const String modalSemiModalVerbsTable = 'Modal_SemiModal_Verbs';
  static const String readingAndListeningTable = 'reading_and_listening';
  static const String sqliteSequenceTable = 'sqlite_sequence';

  // Common Column Names
  static const String idColumn = 'id';
  static const String audioColumn = 'audio';

  // Adjectives Table Columns
  static const String mainAdjColumn = 'main_adj';
  static const String exampleColumn = 'example';
  static const String reverseAdjColumn = 'reverse_adj';
  static const String revExampleColumn = 'rev_example';

  // Nouns Table Columns
  static const String nameColumn = 'name';
  static const String imageColumn = 'image';
  static const String categoryColumn = 'category';

  // Verb Conjugations Table Columns
  static const String baseFormColumn = 'base_form';
  static const String translationColumn = 'translation';
  static const String pastFormColumn = 'past_form';
  static const String pPFormColumn = 'p_p_form';
  static const String verbTypeColumn = 'verb_type';
  static const String audioBlobColumn = 'audio_blob';

  // Base Words Table Columns
  static const String baseWordColumn = 'base_word';
  static const String translationsColumn = 'translations';
  static const String examplesColumn = 'examples';

  // Phrasal Verbs Table Columns
  static const String expressionColumn = 'expression';
  static const String mainVerbColumn = 'main_verb';
  static const String particleColumn = 'particle';
  static const String meaningColumn = 'meaning';
  static const String phrasalVerbTranslationColumn = 'translation';

  // Compound Words Table Columns
  static const String mainColumn = 'main';
  static const String part1Column = 'part1';
  static const String part2Column = 'part2';

  // Expressions Idioms Table Columns
  static const String usageColumn = 'usage';
  static const String typeColumn = 'type';

  // Similar Words Table Columns
  static const String baseWordIdColumn = 'base_word_id';
  static const String similarWordColumn = 'similar_word';

  // English Sentences Table Columns
  static const String sentenceColumn = 'sentence';
  static const String answerColumn = 'answer';
  static const String sentenceTranslationColumn = 'translation';

  // Modal Semi Modal Verbs Table Columns
  static const String modalMainColumn = 'main';
  static const String tenseColumn = 'tense';
  static const String modalTypeColumn = 'type';
  static const String modalTranslationColumn = 'translation';

  // Reading and Listening Table Columns
  static const String titleColumn = 'title';
  static const String contentColumn = 'content';
  static const String soundColumn = 'sound';
  static const String readingTranslationColumn = 'translation';
  static const String readingTypeColumn = 'type';
}
