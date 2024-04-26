import 'package:get/get.dart';

class HotMenuController {
  final isHotMenuOptionsOpened = false.obs;
  final isHotMenuNewOpened = false.obs;
  final isHotMenuOpenOpened = false.obs;
  final isHotMenuEditOpened = false.obs;

  void closeAllPrimaryMenus() {
    isHotMenuOptionsOpened.value = false;
    isHotMenuNewOpened.value = false;
    isHotMenuOpenOpened.value = false;
    isHotMenuEditOpened.value = false;
  }

  void closeAllSecondaryMenus() {
    isHotMenuNewOpened.value = false;
    isHotMenuOpenOpened.value = false;
    isHotMenuEditOpened.value = false;
  }
}
