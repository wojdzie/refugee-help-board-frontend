const _protocol = "http";
const _ip = "172.20.10.2";
const _port = 8080;

serverAddress(String endpoint, [Map<String, dynamic>? query]) => Uri(
    scheme: _protocol,
    host: _ip,
    port: _port,
    path: endpoint,
    queryParameters: query);
