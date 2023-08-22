import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  RxString name = 'Your Name'.obs;
  RxString cityName = 'Country, City'.obs;
  RxString imagePath = ''.obs;

  RxBool is24Hour = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  void save(
    String name,
    String cityName,
    /*Image image*/
  ) async {
    this.name.value = name == '' ? 'Your Name' : name;
    this.cityName.value = cityName == '' ? 'Country, City' : cityName;
    //this.image = image;
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  launchURL(String myUrl) async {
    String url = myUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// void pickImage() async {
//   ImagePicker _picker = ImagePicker();
//   XFile? _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//   image = Image.file(File(_pickedImage!.path));
// }
}
