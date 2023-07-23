import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';

class MqttServerClient {
  final String broker = 'as6o4lcd1bhud-ats.iot.ap-southeast-1.amazonaws.com';
  late MqttClient _client;

  MqttServerClient(String clientId, String thingName) {
    final String clientIdWithThingName = '$clientId-$thingName'; // Combine the clientId and Thing name
    _client = MqttClient(broker, clientIdWithThingName);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>> get updates =>
      _client.updates as Stream<List<MqttReceivedMessage<MqttMessage>>>;

  Future<void> connect() async {
    _client.logging(on: true);
    _client.onConnected = _onConnected;
    _client.onDisconnected = _onDisconnected;
    _client.onSubscribed = _onSubscribed;
    _client.pongCallback = _pong;

    try {
      await _client.connect();
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> subscribe(String topic, MqttQos qos) async {
    _client.subscribe(topic, qos);
  }

  void disconnect() {
    _client.disconnect();
  }

  void _onConnected() {
    print('Connected to MQTT broker');
  }

  void _onDisconnected() {
    print('Disconnected from MQTT broker');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void _pong() {
    print('Ping response received');
  }
}