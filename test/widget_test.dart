import 'package:anime_verse/main.dart';
import 'package:anime_verse/screens/detail_screen.dart';
import 'package:anime_verse/screens/favorite_screen.dart';
import 'package:anime_verse/screens/home_screen.dart';
import 'package:anime_verse/screens/profile_screen.dart';
import 'package:anime_verse/widgets/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> launchApp(WidgetTester tester, {double width = 412}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 915);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    final loader = FontLoader('Urbanist');
    for (final weight in [
      'Regular',
      'Medium',
      'SemiBold',
      'Bold',
      'ExtraBold',
    ]) {
      loader.addFont(rootBundle.load('assets/fonts/Urbanist-$weight.ttf'));
    }
    await loader.load();
  });
  testWidgets('Sign-in and sign-up allow navigation', (tester) async {
    await launchApp(tester);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    await tester.ensureVisible(find.text('Sign Up'));
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Join AnimeVerse!'), findsOneWidget);
    await tester.ensureVisible(find.text('Sign In'));
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Demo sign-in opens catalog, correct detail, tabs and logout', (
    tester,
  ) async {
    await launchApp(tester);
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(AnimeCard), findsWidgets);
    await tester.tap(find.text('My Hero Academia'));
    await tester.pumpAndSettle();
    expect(find.byType(DetailScreen), findsOneWidget);
    expect(find.text('My Hero Academia'), findsOneWidget);
    expect(find.text('Synopsis'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(FavoriteScreen), findsOneWidget);
    await tester.tap(find.byIcon(Icons.person_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);
    await tester.ensureVisible(find.text('Logout'));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Sign-in fits a narrow screen with the keyboard open', (
    tester,
  ) async {
    await launchApp(tester, width: 320);
    await tester.enterText(find.byType(TextField).first, 'student@example.com');
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign In'));
    expect(tester.takeException(), isNull);
  });
}
