const _protocol = "http";
const _ip = "192.168.1.129";
const _port = 8080;

serverAddress(String endpoint) =>
    Uri(scheme: _protocol, host: _ip, port: _port, path: endpoint);
