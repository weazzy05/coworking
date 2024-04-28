import 'package:coworking_mobile/src/feature/app/widget/material_context.dart';
import 'package:coworking_mobile/src/feature/initialization/logic/initialization_processor.dart';
import 'package:coworking_mobile/src/feature/initialization/model/dependencies.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:coworking_mobile/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// Scopes that don't depend on widgets returned by [MaterialApp]
/// ([Directionality], [MediaQuery], [Localizations]) should be placed here.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  /// The initialization result from the [InitializationProcessor]
  /// which contains initialized dependencies.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: DependenciesScope(
          dependencies: result.dependencies,
          child: SettingsScope(
            settingsBloc: result.dependencies.settingsBloc,
            child: const MaterialContext(),
          ),
        ),
      );
}
