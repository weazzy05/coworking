import 'package:coworking_mobile/src/core/constant/config.dart';
import 'package:coworking_mobile/src/core/utils/logger.dart';
import 'package:coworking_mobile/src/feature/acselerator/data/acselerator_list_data_source.dart';
import 'package:coworking_mobile/src/feature/acselerator/data/acselerator_list_repository.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/data/acselerator_details_data_source.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/data/acselerator_details_repository.dart';
import 'package:coworking_mobile/src/feature/app/logic/tracking_manager.dart';
import 'package:coworking_mobile/src/feature/country_list/data/country_list_data_source.dart';
import 'package:coworking_mobile/src/feature/country_list/data/country_list_repository.dart';
import 'package:coworking_mobile/src/feature/initialization/model/dependencies.dart';
import 'package:coworking_mobile/src/feature/rooms_details/data/rooms_details_data_source.dart';
import 'package:coworking_mobile/src/feature/rooms_details/data/rooms_details_repository.dart';
import 'package:coworking_mobile/src/feature/rooms_list/data/rooms_list_data_source.dart';
import 'package:coworking_mobile/src/feature/rooms_list/data/rooms_list_repository.dart';
import 'package:coworking_mobile/src/feature/settings/bloc/settings_bloc.dart';
import 'package:coworking_mobile/src/feature/settings/data/locale_datasource.dart';
import 'package:coworking_mobile/src/feature/settings/data/locale_repository.dart';
import 'package:coworking_mobile/src/feature/settings/data/theme_datasource.dart';
import 'package:coworking_mobile/src/feature/settings/data/theme_mode_codec.dart';
import 'package:coworking_mobile/src/feature/settings/data/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template initialization_processor}
/// A class which is responsible for processing initialization steps.
/// {@endtemplate}
final class InitializationProcessor {
  /// {@macro initialization_processor}
  const InitializationProcessor(this.config);

  /// Application configuration
  final Config config;

  Future<Dependencies> _initDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final errorTrackingManager = await _initErrorTrackingManager();
    final settingsBloc = await _initSettingsBloc(sharedPreferences);
    // TODO(gamzat) change DataSource
    const roomsRepository = RoomsListRepositoryImpl(RoomsListDataSourceLocal());
    const roomsDetailsRepository =
        RoomsDetailsRepositoryImpl(RoomsDetailsDataSourceLocal());
    final countryListRepository =
        CountryListRepositoryImpl(CountryListDataSourceLocal());
    final acseleratorListRepository =
        AcseleratorListRepositoryImpl(AcseleratorListDataSourceLocal());
    final acseleratorDetailsRepository =
        AcseleratorDetailsRepositoryImpl(AcseleratorDetailsDataSourceLocal());

    return Dependencies(
      sharedPreferences: sharedPreferences,
      settingsBloc: settingsBloc,
      errorTrackingManager: errorTrackingManager,
      roomsListRepository: roomsRepository,
      roomsDetailsRepository: roomsDetailsRepository,
      countryListRepository: countryListRepository,
      acseleratorListRepository: acseleratorListRepository,
      acseleratorDetailsRepository: acseleratorDetailsRepository,
    );
  }

  Future<ErrorTrackingManager> _initErrorTrackingManager() async {
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }

  Future<SettingsBloc> _initSettingsBloc(SharedPreferences prefs) async {
    final localeRepository = LocaleRepositoryImpl(
      localeDataSource: LocaleDataSourceLocal(sharedPreferences: prefs),
    );

    final themeRepository = ThemeRepositoryImpl(
      themeDataSource: ThemeDataSourceLocal(
        sharedPreferences: prefs,
        codec: const ThemeModeCodec(),
      ),
    );

    final localeFuture = localeRepository.getLocale();
    final theme = await themeRepository.getTheme();
    final locale = await localeFuture;

    final initialState = SettingsState.idle(appTheme: theme, locale: locale);

    final settingsBloc = SettingsBloc(
      localeRepository: localeRepository,
      themeRepository: themeRepository,
      initialState: initialState,
    );
    return settingsBloc;
  }

  /// Initializes dependencies and returns the result of the initialization.
  ///
  /// This method may contain additional steps that need initialization
  /// before the application starts
  /// (for example, caching or enabling tracking manager)
  Future<InitializationResult> initialize() async {
    final stopwatch = Stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await _initDependencies();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = InitializationResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }
}
