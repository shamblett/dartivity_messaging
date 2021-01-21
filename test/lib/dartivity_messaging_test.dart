/*
 * Package : dartivity_messaging.test
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

@TestOn('vm')
library dartivity_messaging.test;

import 'dart:io';

import 'package:dartivity_messaging/dartivity_messaging.dart';
import 'package:test/test.dart';
import 'package:json_object_lite/json_object_lite.dart' as json;

import 'dartivity_messaging_test_cfg.dart' as cfg;

int main() {
  group('Message Tests', () {
    test('Who Has  - invalid source', () {
      try {
        final message = DartivityMessage.whoHas(null, '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidWhohasMessage);
      }
    });

    test('Who Has  - invalid resource name', () {
      try {
        final message = DartivityMessage.whoHas('', null);
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidWhohasMessage);
      }
    });

    test('Who Has  - invalid host', () {
      try {
        final message = DartivityMessage.whoHas(null, null, null);
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidWhohasMessage);
      }
    });

    test('Who Has  - toJSON', () {
      final message = DartivityMessage.whoHas(
          DartivityMessage.addressWebServer, 'oic/res', 'localhost');
      expect(message.toJSON(),
          "{'type':0,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost','provider':'Unknown','refreshCache':false}");
    });

    test('Who Has  - fromJSON', () {
      final message = DartivityMessage.fromJSON(
          "{'type':0,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost', 'provider':'Unknown','refreshCache':false}");
      expect(message.host, 'localhost');
      expect(message.destination, DartivityMessage.addressGlobal);
      expect(message.source, DartivityMessage.addressWebServer);
      expect(message.resourceDetails, {});
      expect(message.resourceName, 'oic/res');
      expect(message.provider, DartivityMessage.providerUnknown);
      expect(message.refreshCache, false);
    });

    test('Who Has  - fromJSONObject', () {
      final json.JsonObjectLite job = json.JsonObjectLite.fromJsonString(
          "{'type':0,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost', 'provider':'Unknown','refreshCache':true}");
      final message = DartivityMessage.fromJSONObject(job);
      expect(message.host, 'localhost');
      expect(message.destination, DartivityMessage.addressGlobal);
      expect(message.source, DartivityMessage.addressWebServer);
      expect(message.resourceDetails, {});
      expect(message.resourceName, 'oic/res');
      expect(message.provider, DartivityMessage.providerUnknown);
      expect(message.refreshCache, true);
    });

    test('Who Has - toString', () {
      final message = DartivityMessage.whoHas(
          DartivityMessage.addressWebServer, 'oic/res', 'localhost');
      expect(message.toString(),
          'Type : MessageType.whoHas, Provider : Unknown, Host : localhost, Source : web-server, Destination : global, Resource Name : oic/res, Resource Details : {}');
    });

    test('I Have  - invalid source', () {
      try {
        final message = DartivityMessage.iHave(null, '', '', {}, '', '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - invalid destination', () {
      try {
        final message = DartivityMessage.iHave('', null, '', {}, '', '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - invalid resource name', () {
      try {
        final message = DartivityMessage.iHave('', '', null, {}, '', '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - invalid resource details', () {
      try {
        final message = DartivityMessage.iHave('', '', '', null, '', '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - invalid host', () {
      try {
        final message = DartivityMessage.iHave('', '', '', {}, null, '');
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - invalid provider', () {
      try {
        final message = DartivityMessage.iHave('', '', '', {}, '', null);
        print(message);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.invalidIhaveMessage);
      }
    });

    test('I Have  - toJSON', () {
      final message = DartivityMessage.iHave(
          DartivityMessage.addressWebServer,
          DartivityMessage.addressGlobal,
          'oic/res',
          {},
          'localhost',
          DartivityMessage.providerIotivity);
      expect(message.toJSON(),
          "{'type':1,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost','provider':'Iotivity','refreshCache':false}");
    });

    test('I Have  - fromJSON', () {
      final message = DartivityMessage.fromJSON(
          "{'type':1,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost','provider':'Iotivity','refreshCache':false}");
      expect(message.host, 'localhost');
      expect(message.destination, DartivityMessage.addressGlobal);
      expect(message.source, DartivityMessage.addressWebServer);
      expect(message.resourceDetails, {});
      expect(message.resourceName, 'oic/res');
      expect(message.provider, DartivityMessage.providerIotivity);
      expect(message.refreshCache, false);
    });

    test('I Have  - fromJSONObject', () {
      final job = json.JsonObjectLite.fromJsonString(
          "{'type':1,'source':'web-server','destination':'global','resourceName':'oic/res','resourceDetails':{},'host':'localhost', 'provider':'Iotivity','refreshCache':false}");
      final message = DartivityMessage.fromJSONObject(job);
      expect(message.host, 'localhost');
      expect(message.destination, DartivityMessage.addressGlobal);
      expect(message.source, DartivityMessage.addressWebServer);
      expect(message.resourceDetails, {});
      expect(message.resourceName, 'oic/res');
      expect(message.provider, DartivityMessage.providerIotivity);
      expect(message.refreshCache, false);
    });

    test('I Have  - toString', () {
      final message = DartivityMessage.iHave(
          DartivityMessage.addressWebServer,
          DartivityMessage.addressGlobal,
          'oic/res',
          {},
          'localhost',
          DartivityMessage.providerUnknown);
      expect(message.toString(),
          'Type : MessageType.iHave, Provider : Unknown, Host : localhost, Source : web-server, Destination : global, Resource Name : oic/res, Resource Details : {}');
    });
  });

  group('Messaging Tests', () {
    // Create our messaging test clients
    final client1 = DartivityMessaging(cfg.clientId1);
    final client2 = DartivityMessaging(cfg.clientId2);

    test('Send before initialised', () async {
      final noSend = DartivityMessage.iHave(
          '', '', '', {}, '', DartivityMessage.providerIotivity);
      final res = await client1.send(noSend);
      expect(res, isNull);
    });

    test('Receive before initialised', () async {
      final res = await client1.receive();
      expect(res, isNull);
    });

    test('Initialise - No credentials', () async {
      try {
        final res =
            await client1.initialise(null, cfg.messProjectId, cfg.messTopic);
        print(res);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.noCredfileSpecified);
      }
    });

    test('Initialise - No project name', () async {
      try {
        final res =
            await client1.initialise(cfg.messCredPath, null, cfg.messTopic);
        print(res);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.noProjectnameSpecified);
      }
    });

    test('Initialise - No topic', () async {
      try {
        final res =
            await client1.initialise(cfg.messCredPath, cfg.messTopic, null);
        print(res);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.header +
                DartivityMessagingException.noTopicSpecified);
      }
    });

    test('Initialise - send/receive', () async {
      final credentialsPath = Directory.current.path + cfg.messCredPath;
      print('Credentials path: $credentialsPath');
      var res = await client1.initialise(
          credentialsPath, cfg.messProjectId, cfg.messTopic);
      expect(res, true);
      expect(client1.ready, true);

      res = await client2.initialise(
          credentialsPath, cfg.messProjectId, cfg.messTopic);
      expect(res, true);
      expect(client2.ready, true);

      final whoHas = DartivityMessage.whoHas(
          DartivityMessage.addressWebServer, 'oic/res', 'localhost');

      var message = await client1.send(whoHas);
      expect(message, isNotNull);

      message = await client2.receive();
      expect(message, isNotNull);
      expect(message.type, MessageType.whoHas);
      expect(message.destination, DartivityMessage.addressGlobal);
      expect(message.host, 'localhost');
      expect(message.source, DartivityMessage.addressWebServer);
    });

    test('Close', () async {
      client1.close();
      expect(client1.ready, false);
      client2.close(false);
      expect(client2.ready, false);
    });
  });

  return 0;
}
