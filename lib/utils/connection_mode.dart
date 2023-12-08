
class ConnectionMode {
  static String getConnectionUrl() {
    return '192.168.0.123:8080';
  }

  Map<String,String> getHeaders(){
    return {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
    };
  }
}
