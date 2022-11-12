import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> injectionConfiguration() async {
  await $initGetIt(getIt, environment: Environment.prod);
}
