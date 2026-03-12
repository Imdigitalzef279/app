import 'package:solar_energy/l10n/app_localizations.dart';

import '../utils/navigation_utils.dart';

class LocalizationsUtils {
  static final AppLocalizations localizations =
      AppLocalizations.of(NavigatorUtils.navigatorKey.currentContext!)!;
}
