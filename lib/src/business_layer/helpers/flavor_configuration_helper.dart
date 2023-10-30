import 'package:flutter/material.dart';

import '../../../app_settings.dart';
import '../network/api_constants.dart';

/// enum class for the different flavors
enum Flavor { dev, qa, production }

/// class for the different flavor values
class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    required this.apiKey,
  });

  final String baseUrl;
  final String apiKey;
}

/// class for the flavor configuration
class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static late FlavorConfig _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color color = Colors.blue,
      required FlavorValues values}) {
    _instance = FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      color,
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
    this.color,
    this.values,
  );

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.production;

  static bool isDevelopment() => _instance.flavor == Flavor.dev;

  static bool isQA() => _instance.flavor == Flavor.qa;

  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static void setServerConfig() {
    /// setting the server flavor
    Flavor flavor = AppSettings.flavor;

    /// this will set the server config based on the flavor
    if (flavor == Flavor.production) {
      FlavorConfig(
          flavor: Flavor.production,
          values: FlavorValues(
            baseUrl: ApiConstants.urlProdServer,
            apiKey: ApiConstants.prodApiKey,
          ));
    } else if (flavor == Flavor.qa) {
      FlavorConfig(
          flavor: Flavor.qa,
          values: FlavorValues(
            baseUrl: ApiConstants.urlTestServer,
            apiKey: ApiConstants.testApiKey,
          ));
    } else {
      FlavorConfig(
          flavor: Flavor.dev,
          values: FlavorValues(
            baseUrl: ApiConstants.urlDevServer,
            apiKey: ApiConstants.devApiKey,
          ));
    }
  }
}
