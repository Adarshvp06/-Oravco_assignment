enum AppEnv { local, staging, prod }

class AppConfig {
  static late AppEnv _environment;

  static void initialize() {
    const env = String.fromEnvironment('ENV', defaultValue: 'local');

    switch (env) {
      case 'staging':
        _environment = AppEnv.staging;
        break;
      case 'prod':
        _environment = AppEnv.prod;
        break;
      default:
        _environment = AppEnv.local;
    }
  }

  static AppEnv get environment => _environment;

  static String get baseUrl {
    switch (_environment) {
      case AppEnv.staging:
        return 'https://fakestoreapi.com/';
      case AppEnv.prod: 
        return 'https://fakestoreapi.com/';
      case AppEnv.local:
        return 'https://fakestoreapi.com/';
    }
  }

  static bool get isLocal => _environment == AppEnv.local;
  static bool get isStaging => _environment == AppEnv.staging;
  static bool get isProd => _environment == AppEnv.prod;
}
