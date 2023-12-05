import 'src/business_layer/helpers/flavor_configuration_helper.dart';

class AppSettings {
  /// This variable is used to disable the logs
  /// make it true when deploying to production
  static const bool disableLogs = false;

  /// This variable is used to set the server config
  /// flavors -> dev, staging, production
  static Flavor flavor = Flavor.qa;
}
