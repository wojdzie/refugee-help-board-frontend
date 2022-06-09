const _protocol = "http";
const _ip = "127.0.0.1";
const _port = 8080;

serverAddress(String endpoint, [Map<String, dynamic>? query]) => Uri(
    scheme: _protocol,
    host: _ip,
    port: _port,
    path: endpoint,
    queryParameters: query);
