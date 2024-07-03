import 'package:get/get.dart';
import 'package:teledocuser/model/catogary/catogary_model.dart';



class CategariController extends GetxController {
  CategoryModel? data; 

  void setSelectedCategory(CategoryModel category) {
    data = category;
  }
}
