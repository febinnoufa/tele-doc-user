import 'package:get/get.dart';

import 'package:teledocuser/views/widgets/home/catigarywidget.dart'; 

class CategariController extends GetxController {
  CategoryModel? data; 

  void setSelectedCategory(CategoryModel category) {
    data = category;
  }
}
