import 'package:get_it/get_it.dart';
import 'package:note_app/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final localStorage = await LocalStorage.getInstance();
  locator.registerSingleton<LocalStorage>(localStorage);
}
