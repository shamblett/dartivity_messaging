/*
 * Package : dartivity_messaging.test
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

@TestOn("vm")
library dartivity_messaging.test;

import 'package:dartivity_messaging/dartivity_messaging.dart';
import 'package:test/test.dart';
import 'package:json_object/json_object.dart' as json;

import 'dartivity_messaging_test_cfg.dart' as cfg;

int main() {
  group("Message Tests", () {
    test("Who Has  - invalid source", () {
      try {
        DartivityMessage message = new DartivityMessage.whoHas(null, "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_WHOHAS_MESSAGE);
      }
    });

    test("Who Has  - invalid resource name", () {
      try {
        DartivityMessage message = new DartivityMessage.whoHas("", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_WHOHAS_MESSAGE);
      }
    });

    test("Who Has  - invalid host", () {
      try {
        DartivityMessage message =
        new DartivityMessage.whoHas(null, null, null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_WHOHAS_MESSAGE);
      }
    });

    test("Who Has  - toJSON", () {
      DartivityMessage message = new DartivityMessage.whoHas(
          DartivityMessage.ADDRESS_WEB_SERVER, "oic/res", "localhost");
      expect(message.toJSON(),
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Unknown","refreshCache":false}');
    });

    test("Who Has  - fromJSON", () {
      DartivityMessage message = new DartivityMessage.fromJSON(
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Unknown","refreshCache":false}');
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_UNKNOWN);
      expect(message.refreshCache, false);
    });

    test("Who Has  - fromJSONObject", () {
      json.JsonObject job = new json.JsonObject.fromJsonString(
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Unknown","refreshCache":true}');
      DartivityMessage message = new DartivityMessage.fromJSONObject(job);
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_UNKNOWN);
      expect(message.refreshCache, true);
    });

    test("Who Has - toString", () {
      DartivityMessage message = new DartivityMessage.whoHas(
          DartivityMessage.ADDRESS_WEB_SERVER, "oic/res", "localhost");
      expect(message.toString(),
          "Type : MessageType.whoHas, Provider : Unknown, Host : localhost, Source : web-server, Destination : global, Resource Name : oic/res, Resource Details : {}");
    });

    test("I Have  - invalid source", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave(null, "", "", {}, "", "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - invalid destination", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave("", null, "", {}, "", "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - invalid resource name", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave("", "", null, {}, "", "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - invalid resource details", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave("", "", "", null, "", "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - invalid host", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave("", "", "", {}, null, "");
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - invalid provider", () {
      try {
        DartivityMessage message =
        new DartivityMessage.iHave("", "", "", {}, "", null);
      } catch (e) {
        expect(e.runtimeType.toString(), 'DartivityMessagingException');
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.INVALID_IHAVE_MESSAGE);
      }
    });

    test("I Have  - toJSON", () {
      DartivityMessage message = new DartivityMessage.iHave(
          DartivityMessage.ADDRESS_WEB_SERVER,
          DartivityMessage.ADDRESS_GLOBAL,
          "oic/res",
          {},
          "localhost",
          DartivityMessage.PROVIDER_IOTIVITY);
      expect(message.toJSON(),
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Iotivity","refreshCache":false}');
    });

    test("I Have  - fromJSON", () {
      DartivityMessage message = new DartivityMessage.fromJSON(
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Iotivity","refreshCache":false}');
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_IOTIVITY);
      expect(message.refreshCache, false);
    });

    test("I Have  - fromJSONObject", () {
      json.JsonObject job = new json.JsonObject.fromJsonString(
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Iotivity","refreshCache":false}');
      DartivityMessage message = new DartivityMessage.fromJSONObject(job);
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_IOTIVITY);
      expect(message.refreshCache, false);
    });

    test("I Have  - toString", () {
      DartivityMessage message = new DartivityMessage.iHave(
          DartivityMessage.ADDRESS_WEB_SERVER,
          DartivityMessage.ADDRESS_GLOBAL,
          "oic/res",
          {},
          "localhost",
          DartivityMessage.PROVIDER_UNKNOWN);
      expect(message.toString(),
          "Type : MessageType.iHave, Provider : Unknown, Host : localhost, Source : web-server, Destination : global, Resource Name : oic/res, Resource Details : {}");
    });
  });

  group("Messaging Tests", () {
    // Create our messaging test clients
    DartivityMessaging client1 = new DartivityMessaging(cfg.clientId1);
    DartivityMessaging client2 = new DartivityMessaging(cfg.clientId2);

    test("Send before initialised", () async {
      DartivityMessage noSend = new DartivityMessage.iHave(
          "", "", "", {}, "", DartivityMessage.PROVIDER_IOTIVITY);
      var res = await client1.send(noSend);
      expect(res, isNull);
    });

    test("Receive before initialised", () async {
      var res = await client1.receive();
      expect(res, isNull);
    });

    test("Initialise - No credentials", () async {
      try {
        bool res =
        await client1.initialise(null, cfg.MESS_PROJECT_ID, cfg.MESS_TOPIC);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.NO_CREDFILE_SPECIFIED);
      }
    });

    test("Initialise - No project name", () async {
      try {
        bool res =
        await client1.initialise(cfg.MESS_CRED_PATH, null, cfg.MESS_TOPIC);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.NO_PROJECTNAME_SPECIFIED);
      }
    });

    test("Initialise - No topic", () async {
      try {
        bool res =
        await client1.initialise(cfg.MESS_CRED_PATH, cfg.MESS_TOPIC, null);
      } catch (e) {
        expect(
            e.toString(),
            DartivityMessagingException.HEADER +
                DartivityMessagingException.NO_TOPIC_SPECIFIED);
      }
    });

    test("Initialise - send/receive", () async {
      bool res = await client1.initialise(
          cfg.MESS_CRED_PATH, cfg.MESS_PROJECT_ID, cfg.MESS_TOPIC);
      expect(res, true);
      expect(client1.ready, true);

      res = await client2.initialise(
          cfg.MESS_CRED_PATH, cfg.MESS_PROJECT_ID, cfg.MESS_TOPIC);
      expect(res, true);
      expect(client2.ready, true);

      DartivityMessage whoHas = new DartivityMessage.whoHas(
          DartivityMessage.ADDRESS_WEB_SERVER, "oic/res", "localhost");

      DartivityMessage message = await client1.send(whoHas);
      expect(message, isNotNull);

      message = await client2.receive();
      expect(message, isNotNull);
      expect(message.type, MessageType.whoHas);
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.host, 'localhost');
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
    });

    test("Close", () async {
      client1.close();
      expect(client1.ready, false);
      client2.close(false);
      expect(client2.ready, false);
    });
  });

  return 0;
}
