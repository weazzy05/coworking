import 'dart:async';

import 'package:coworking_mobile/src/core/utils/logger.dart';
import 'package:coworking_mobile/src/feature/app/logic/app_runner.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
