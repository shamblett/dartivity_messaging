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
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Unknown"}');
    });

    test("Who Has  - fromJSON", () {
      DartivityMessage message = new DartivityMessage.fromJSON(
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Unknown"}');
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_UNKNOWN);
    });

    test("Who Has  - fromJSONObject", () {
      json.JsonObject job = new json.JsonObject.fromJsonString(
          '{"type":0,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Unknown"}');
      DartivityMessage message = new DartivityMessage.fromJSONObject(job);
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_UNKNOWN);
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
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Iotivity"}');
    });

    test("I Have  - fromJSON", () {
      DartivityMessage message = new DartivityMessage.fromJSON(
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost","provider":"Iotivity"}');
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_IOTIVITY);
    });

    test("I Have  - fromJSONObject", () {
      json.JsonObject job = new json.JsonObject.fromJsonString(
          '{"type":1,"source":"web-server","destination":"global","resourceName":"oic/res","resourceDetails":{},"host":"localhost", "provider":"Iotivity"}');
      DartivityMessage message = new DartivityMessage.fromJSONObject(job);
      expect(message.host, "localhost");
      expect(message.destination, DartivityMessage.ADDRESS_GLOBAL);
      expect(message.source, DartivityMessage.ADDRESS_WEB_SERVER);
      expect(message.resourceDetails, {});
      expect(message.resourceName, "oic/res");
      expect(message.provider, DartivityMessage.PROVIDER_IOTIVITY);
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

//
//Future main() async {
//  final int badExitCode = -1;
//
//  // Instantiate a Dartivity client and initialise for
//  // messaging only
//  Dartivity dartivity = new Dartivity(Mode.messagingOnly);
//
//  // Send before ready
//  DartivityMessage noSend = new DartivityMessage.iHave("", "", "", {}, "");
//  var result = dartivity.send(noSend);
//  if (result == null) {
//    print("Message not sent not ready - OK");
//  } else {
//    print("Oops message sent when not ready- ERROR");
//    exit(badExitCode);
//  }
//
//  // Initialise
//  await dartivity.initialise(
//      DartivityCfg.MESS_CRED_PATH, DartivityCfg.MESS_PROJECT_ID);
//
//  if (dartivity.initialised) {
//    print("Initialse Status is true - OK");
//  } else {
//    print("Oops Initialse Status is false - ERROR");
//    exit(badExitCode);
//  }
//
//  // Send a null message
//  var result1 = dartivity.send(null);
//  if (result1 == null) {
//    print("Null message not sent - OK");
//  } else {
//    print("Oops null message sent - ERROR");
//    exit(badExitCode);
//  }
//
//  // Send a couple of whoHas messages
//  DartivityMessage whoHas1 =
//  new DartivityMessage.whoHas(dartivity.id, '/core/light');
//  String whoHas1Json = whoHas1.toJSON();
//  print("Who Has 1 >> ${whoHas1Json}");
//  dartivity.send(whoHas1);
//  DartivityMessage whoHas2 =
//  new DartivityMessage.whoHas(dartivity.id, '/core/thermostat');
//  dartivity.send(whoHas2);
//
//  // Followed by a I Have
//  Map<String, String> myDevice = {'iama': 'thermostat', 'url': 'here.com/ami'};
//  DartivityMessage iHave = new DartivityMessage.iHave(
//      dartivity.id, dartivity.id, '/core/therm/1', myDevice, "");
//  dartivity.send(iHave);
//
//  // Followed by a I Have but not for us
//  Map<String, String> myDevice1 = {'iama': 'thermostat', 'url': 'here.com/ami'};
//  DartivityMessage iHave1 = new DartivityMessage.iHave(
//      dartivity.id, 'not us', '/core/therm/1', myDevice1, "");
//  dartivity.send(iHave1);
//
//  // Listen for our messages until our timer pops
//  var subscription;
//  int messCount = 0;
//
//  void timerCallback() {
//    print("Closing the client");
//    if (messCount == 3) {
//      print("Message count is 3 - OK");
//    } else {
//      print("Message count is ${messCount} - ERROR, should be 3");
//      exit(badExitCode);
//    }
//    subscription.cancel();
//    try {
//      dartivity.close();
//    } catch (e) {}
//    // Good exit
//    exit(0);
//  }
//  Timer timer = new Timer(
//      new Duration(seconds: (DartivityCfg.MESS_PULL_TIME_INTERVAL * 7 + 2)),
//      timerCallback);
//
//  subscription = dartivity.nextMessage.listen((DartivityMessage message) {
//    print("Message received ${message.toString()}");
//    messCount++;
//  });
//}
