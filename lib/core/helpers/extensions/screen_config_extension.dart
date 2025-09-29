
import 'package:projectflow_web/presentation/utils/screen_configuration.dart';

extension ScreenExtensions on num {
  static final ScreenConfiguration _screenUtility = ScreenConfiguration();

  double get w => _screenUtility.setWidth(this);

  double get h => _screenUtility.setHeight(this);
}
