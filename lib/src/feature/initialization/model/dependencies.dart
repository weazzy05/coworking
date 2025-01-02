import 'package:coworking_mobile/src/feature/app/logic/tracking_manager.dart';
import 'package:coworking_mobile/src/feature/country_list/data/country_list_repository.dart';
import 'package:coworking_mobile/src/feature/rooms_details/data/rooms_details_repository.dart';
import 'package:coworking_mobile/src/feature/rooms_list/data/rooms_list_repository.dart';
import 'package:coworking_mobile/src/feature/settings/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template dependencies}
/// Dependencies container
/// {@endtemplate}
base class Dependencies {
  /// {@macro dependencies}
  const Dependencies({
    required this.sharedPreferences,
    required this.settingsBloc,
    required this.errorTrackingManager,
    required this.roomsListRepository,
    required this.roomsDetailsRepository,
    required this.countryListRepository,
  });

  /// [SharedPreferences] instance, used to store Key-Value pairs.
  final SharedPreferences sharedPreferences;

  /// [SettingsBloc] instance, used to manage theme and locale.
  final SettingsBloc settingsBloc;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;

  /// [RoomsListRepository] instance, used to room list repository.
  final RoomsListRepository roomsListRepository;

  final RoomsDetailsRepository roomsDetailsRepository;

  final CountryListRepository countryListRepository;
}

/// {@template initialization_result}
/// Result of initialization
/// {@endtemplate}
final class InitializationResult {
  /// {@macro initialization_result}
  const InitializationResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies
  final Dependencies dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
