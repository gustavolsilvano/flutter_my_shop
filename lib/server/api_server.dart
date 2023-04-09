import 'package:http/http.dart' as http;

class API {
  String endpoint = 'flutter-update-e355d-default-rtdb.firebaseio.com';

  Future<void> post(String path, var data) async {
    Uri uri = Uri.https(endpoint, path);
    await http.post(uri, body: data);
  }
}
