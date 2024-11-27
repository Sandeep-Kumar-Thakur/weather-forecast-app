import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // TODO: implement send
    print("end-point : ${request.url.path}");
    return _inner.send(request);
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? headers, Object? body}) {
    // TODO: implement post
    return super.get(url, headers: headers);
  }
}
