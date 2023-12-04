import 'dart:io';

class ConnectionMode {
  static final HttpClient client = HttpClient();
  static String getConnectionUrl() {
    return '192.168.0.123:8080';
  }

  static Map<String,String> getHeaders(){
    return {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "User-Agent": client.userAgent!,
    };
  }
}
