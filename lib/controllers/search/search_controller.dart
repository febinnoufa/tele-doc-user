
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class SearchControllerDoc extends GetxController {
  var name = ''.obs;

  void filterByName(String val) {
    name.value = val;
  }
}