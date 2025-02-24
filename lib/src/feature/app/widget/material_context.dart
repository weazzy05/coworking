import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/acselerator/widget/acselerator_screen.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/widget/acselerator_details_screen.dart';
import 'package:coworking_mobile/src/feature/country_list/widget/country_list_screen.dart';
import 'package:coworking_mobile/src/feature/rooms_details/widget/rooms_details_screen.dart';
import 'package:coworking_mobile/src/feature/rooms_list/widget/rooms_list_screen.dart';
import 'package:coworking_mobile/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;

    return MaterialApp.router(
      theme: theme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
      routerConfig: _router,
      // TODO: You may want to override the default text scaling behavior.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        key: _globalKey,
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: child!,
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CountryListScreen(),
      routes: [
        GoRoute(
          path: 'rooms/:cityId',
          name: 'rooms',
          builder: (context, state) => RoomsListScreen(
            cityId: state.pathParameters['cityId']!,
          ),
          routes: [
            GoRoute(
              path: 'room/:roomId',
              name: 'room_details',
              builder: (context, state) => RoomsDetailsScreen(
                roomId: state.pathParameters['roomId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'acselerators',
          name: 'acselerators',
          builder: (context, state) => AcseleratorListScreen(),
          routes: [
            GoRoute(
              path: 'acselerator/:id',
              name: 'acselerator_details',
              builder: (context, state) => AcseleratorDetailsScreen(
                acselectorId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
