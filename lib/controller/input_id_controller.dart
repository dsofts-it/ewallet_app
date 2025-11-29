import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Import for TextEditingController

class InputIdController extends GetxController {
  String defaultInfo = 'Input your user ID to select a product';
  var inputIdText = ''.obs; 
  var infoText = ''.obs;
  var isValidInput = false.obs;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    infoText.value = defaultInfo;

    textEditingController.addListener(() {
      /// SET TEXT VALUE
      inputIdText.value = textEditingController.text;

      /// VALIDATE TEXT INPUT
      if(inputIdText.value.length < 4) {
        isValidInput.value = false;
      } else {
        isValidInput.value = true;
      }
    });
  }

  @override
  void onClose() {
    textEditingController.dispose(); // Dispose the controller to prevent memory leaks
    super.onClose();
  }

  // Method to update the observable text (if using RxString directly)
  void updateText(String value) {
    textEditingController.text = value;
    update();
  }
}