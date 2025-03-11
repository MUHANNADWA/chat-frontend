import 'package:chatbotstudy/utils/helpers/network_manager.dart';
import 'package:chatbotstudy/utils/local_storage/storage_utility.dart';
import 'package:chatbotstudy/utils/locale/locale_controller.dart';
import 'package:chatbotstudy/utils/theme/theme_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AppLocaleController());
    Get.put(AppLocalStorage());
    Get.put(AppThemeController());
  }
}
