import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PermissionController extends GetxController {
  final String permissionStatusKey = 'videoPermission';

  Future<bool> hasPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    return prefs.getBool(permissionStatusKey) ?? false;
  }

  Future<void> savePermissionStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(permissionStatusKey, status);
  }
}
