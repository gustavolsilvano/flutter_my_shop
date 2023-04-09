import 'package:http/http.dart' as http;

class API {
  String endpoint = 'flutter-update-e355d-default-rtdb.firebaseio.com';

  Future<http.Response> post(String path, var data) async {
    Uri uri = Uri.https(endpoint, path);
    return await http.post(uri, body: data);
  }

  Future<http.Response> get(String path) async {
    Uri uri = Uri.https(endpoint, path);
    return await http.get(uri);
  }
}
