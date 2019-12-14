import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

main() {
  tearDown(() {
    clearCache();
  });

  //////////////////////////////
  // Derived fontFamily tests //
  //////////////////////////////

  testWidgets('Text style with a direct match is used', (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    final outputTextStyle = GoogleFonts.roboto(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_regular'));
  });

  testWidgets('Text style with an italics direct match is used',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle = GoogleFonts.roboto(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_italic'));
  });

  testWidgets('Text style with no direct match picks closest font weight match',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );

    final outputTextStyle = GoogleFonts.roboto(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_500'));
  });

  testWidgets('Italic text style with no direct match picks closest match',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle = GoogleFonts.roboto(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_500italic'));
  });

  testWidgets('Text style prefers matching italics to closer weight',
      (tester) async {
    // Cardo has 400regular, 400italic, and 700 regular. Even though 700 is
    // closer in weight, when we ask for 600italic, it will give us 400 italic
    // font family.
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle = GoogleFonts.cardo(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Cardo_italic'));
  });

  testWidgets('Defaults to regular when no Text style is passed',
      (tester) async {
    final outputTextStyle = GoogleFonts.lato();

    expect(outputTextStyle.fontFamily, equals('Lato_regular'));
  });

  testWidgets(
      'Defaults to regular when a Text style with no weight or style is passed',
      (tester) async {
    final outputTextStyle = GoogleFonts.lato(textStyle: TextStyle());

    expect(outputTextStyle.fontFamily, equals('Lato_regular'));
  });

  ///////////////////////////
  // TextStyle param tests //
  ///////////////////////////

  testWidgets('color is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(color: Color(0xDEADBEEF));
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.color, equals(Color(0xDEADBEEF)));
  });

  testWidgets('color is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(color: Color(0xFACEFEED));

    expect(outputTextStyle.color, equals(Color(0xFACEFEED)));
  });

  testWidgets(
      'color from the top-level param takes precedence over color '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(color: Color(0xDEADBEEF));
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      color: Color(0xFACEFEED),
    );

    expect(outputTextStyle.color, Color(0xFACEFEED));
  });

  testWidgets(
      'backgroundColor is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(backgroundColor: Color(0xDEADBEEF));
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.backgroundColor, equals(Color(0xDEADBEEF)));
  });

  testWidgets('backgroundColor is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle =
        GoogleFonts.rancho(backgroundColor: Color(0xFACEFEED));

    expect(outputTextStyle.backgroundColor, equals(Color(0xFACEFEED)));
  });

  testWidgets(
      'backgroundColor from the top-level param takes precedence over '
      'backgroundColor from TextStyle param', (tester) async {
    final textStyle = TextStyle(backgroundColor: Color(0xDEADBEEF));
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      backgroundColor: Color(0xFACEFEED),
    );

    expect(outputTextStyle.backgroundColor, Color(0xFACEFEED));
  });

  testWidgets('fontSize is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(fontSize: 37);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.fontSize, equals(37));
  });

  testWidgets('fontSize is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(fontSize: 31);

    expect(outputTextStyle.fontSize, equals(31));
  });

  testWidgets(
      'fontSize from the top-level param takes precedence over fontSize '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(fontSize: 37);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      fontSize: 31,
    );

    expect(outputTextStyle.fontSize, equals(31));
  });

  testWidgets('fontWeight is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(fontWeight: FontWeight.w800);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.fontWeight, equals(FontWeight.w800));
  });

  testWidgets('fontWeight is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(fontWeight: FontWeight.w200);

    expect(outputTextStyle.fontWeight, equals(FontWeight.w200));
  });

  testWidgets(
      'fontWeight from the top-level param takes precedence over fontWeight '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(fontWeight: FontWeight.w800);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      fontWeight: FontWeight.w200,
    );

    expect(outputTextStyle.fontWeight, equals(FontWeight.w200));
  });

  testWidgets('fontStyle is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(fontStyle: FontStyle.normal);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.fontStyle, equals(FontStyle.normal));
  });

  testWidgets('fontStyle is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(fontStyle: FontStyle.italic);

    expect(outputTextStyle.fontStyle, equals(FontStyle.italic));
  });

  testWidgets(
      'fontStyle from the top-level param takes precedence over fontStyle '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(fontStyle: FontStyle.normal);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      fontStyle: FontStyle.italic,
    );

    expect(outputTextStyle.fontStyle, equals(FontStyle.italic));
  });

  testWidgets('letterSpacing is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(letterSpacing: 0.4);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.letterSpacing, equals(0.4));
  });

  testWidgets('letterSpacing is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(letterSpacing: 0.3);

    expect(outputTextStyle.letterSpacing, equals(0.3));
  });

  testWidgets(
      'letterSpacing from the top-level param takes precedence over '
      'letterSpacing from the TextStyle param', (tester) async {
    final textStyle = TextStyle(letterSpacing: 0.4);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      letterSpacing: 0.3,
    );

    expect(outputTextStyle.letterSpacing, equals(0.3));
  });

  testWidgets('wordSpacing is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(wordSpacing: 0.4);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.wordSpacing, equals(0.4));
  });

  testWidgets('wordSpacing is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(wordSpacing: 0.3);

    expect(outputTextStyle.wordSpacing, equals(0.3));
  });

  testWidgets(
      'wordSpacing from the top-level param takes precedence over wordSpacing '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(wordSpacing: 0.4);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      wordSpacing: 0.3,
    );

    expect(outputTextStyle.wordSpacing, equals(0.3));
  });

  testWidgets('textBaseline is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(textBaseline: TextBaseline.ideographic);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.textBaseline, equals(TextBaseline.ideographic));
  });

  testWidgets('textBaseline is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle =
        GoogleFonts.rancho(textBaseline: TextBaseline.alphabetic);

    expect(outputTextStyle.textBaseline, equals(TextBaseline.alphabetic));
  });

  testWidgets(
      'textBaseline from the top-level param takes precedence over textBaseline'
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(textBaseline: TextBaseline.ideographic);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      textBaseline: TextBaseline.alphabetic,
    );

    expect(outputTextStyle.textBaseline, equals(TextBaseline.alphabetic));
  });

  testWidgets('height is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(height: 33);
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.height, equals(33));
  });

  testWidgets('height is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(height: 37);

    expect(outputTextStyle.height, equals(37));
  });

  testWidgets(
      'height from the top-level param takes precedence over height '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(height: 33);
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      height: 37,
    );

    expect(outputTextStyle.height, equals(37));
  });

  testWidgets('locale is honored when passed in via the TextStyle param',
      (tester) async {
    final textStyle = TextStyle(locale: const Locale('abc'));
    final outputTextStyle = GoogleFonts.rancho(textStyle: textStyle);

    expect(outputTextStyle.locale, equals(const Locale('abc')));
  });

  testWidgets('locale is honored when passed in as a top-level param',
      (tester) async {
    final outputTextStyle = GoogleFonts.rancho(locale: const Locale('xyz'));

    expect(outputTextStyle.locale, equals(const Locale('xyz')));
  });

  testWidgets(
      'locale from the top-level param takes precedence over locale '
      'from the TextStyle param', (tester) async {
    final textStyle = TextStyle(locale: const Locale('anc'));
    final outputTextStyle = GoogleFonts.rancho(
      textStyle: textStyle,
      locale: const Locale('xyz'),
    );

    expect(outputTextStyle.locale, equals(const Locale('xyz')));
  });

  /////////////////////
  // TextTheme tests //
  /////////////////////

  testWidgets('TextTheme method works in the default case', (tester) async {
    final textTheme = GoogleFonts.oswaldTextTheme();
    final expectedFamilyWithVariant = 'Oswald_regular';

    expect(textTheme.display4.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display3.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display2.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display1.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.headline.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.title.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.subhead.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.body2.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.body1.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.caption.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.button.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.subtitle.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.overline.fontFamily, equals(expectedFamilyWithVariant));
  });

  testWidgets('TextTheme method works with a base textTheme', (tester) async {
    // In app this is usually obtained by Theme.of(context).textTheme.
    final baseTextTheme = TextTheme(
      display2: TextStyle(fontWeight: FontWeight.w700),
      body1: GoogleFonts.acme(),
      subtitle: TextStyle(fontStyle: FontStyle.italic),
    );

    final textTheme = GoogleFonts.oswaldTextTheme(baseTextTheme);
    final expectedFamilyWithVariant = 'Oswald_regular';

    // Default is preserved.
    expect(textTheme.display1.fontFamily, equals(expectedFamilyWithVariant));
    // Different font family gets overridden by oswald.
    expect(textTheme.body1.fontFamily, equals(expectedFamilyWithVariant));
    // Weight is preserved.
    expect(textTheme.display2.fontWeight, equals(FontWeight.w700));
    // Style is preserved.
    expect(textTheme.subtitle.fontStyle, equals(FontStyle.italic));
  });
}
