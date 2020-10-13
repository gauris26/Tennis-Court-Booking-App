import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<String> getResponseBody() async {
    final responseBody = await http.get(url);
    return responseBody.body;
  }
}
