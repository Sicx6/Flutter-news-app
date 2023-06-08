import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  Fluttertoast.showToast(msg: 'No Image selected');
}
