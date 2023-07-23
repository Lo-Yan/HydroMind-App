import 'package:flutter/material.dart';

import '/screens/mqtt-service/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTScreen extends StatefulWidget {
  @override
  _MQTTScreenState createState() => _MQTTScreenState();
}

class _MQTTScreenState extends State<MQTTScreen> {
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    client = MqttServerClient('as6o4lcd1bhud-ats.iot.ap-southeast-1.amazonaws.com', 'esp32_test');
    _connect();
  }

  Future<void> _connect() async {
    await client.connect();
    await client.subscribe('esp32/sub', MqttQos.atLeastOnce);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Client'),
      ),
      body: Center(
        child: StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
          stream: client.updates,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final mqttMessages = snapshot.data!;
            final receivedMessage = mqttMessages.first.payload as MqttPublishMessage;
            final payload = MqttPublishPayload.bytesToStringAsString(receivedMessage.payload.message!);

            return Text('Received payload: $payload');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }
}