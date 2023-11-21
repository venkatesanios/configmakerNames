import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService_mob {
  final clientMob = MqttServerClient('192.168.1.141', 'niagara');
  void initializeMqttClient() async {
    clientMob.port = 1883;
    clientMob.keepAlivePeriod = 20;
    clientMob.onDisconnected = onDisconnected;
    clientMob.logging(on: false);
    clientMob.onSubscribed = onSubscribed;
    clientMob.onConnected = onConnected;
    try {
      await clientMob.connect();
      print('yes connected');
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      clientMob.disconnect();
    }
  }

  void onSubscribed(String topic) {
    print('topic : ${topic}');
  }

  void onDisconnected() {
    print('Device disconnected');
  }

  void onConnected() {
    print('connected');
  }

  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
}
