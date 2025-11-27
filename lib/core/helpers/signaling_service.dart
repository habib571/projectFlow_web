import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants/endpoints.dart';

class SignalingService {
  late WebSocketChannel _channel;
  Function(Map<String, dynamic> m)? onMessageReceived;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(Endpoints.signalingUrl));

    _channel.stream.listen((message) {
      if (onMessageReceived != null) {
        onMessageReceived!(jsonDecode(message));
        print("WebSocket message: $message");
      }
    }
        , onError: (error) {
          print("WebSocket error: $error");
        }, onDone: () {
          print("WebSocket closed");
        });
  }

  void send(Map<String, dynamic> data) {
    _channel.sink.add(jsonEncode(data));
  }

  void close() {
    _channel.sink.close();
  }
}
