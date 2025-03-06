// import 'dart:io';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class AbstractNetworkHelper {
  Future<String> get(String url);
}

class APIClient implements AbstractNetworkHelper {
  final http.BaseClient client;
  APIClient(this.client);

  @override
  Future<String> get(String endpoint) async {
    final url = Uri.parse(endpoint);
    final data = await client.get(url);
    return data.body;
    //TODO: handle exception here
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
