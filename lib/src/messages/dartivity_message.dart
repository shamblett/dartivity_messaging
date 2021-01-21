/*
 * Package : dartivity_messaging
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

/// This class defines the Dartivity suite messaging interface comprising
/// of a general message class that can be constructed to provide the
/// following messages :-
///
/// 1. whoHas - this message can be issued by any Dartivity component to
/// all other components asking for details of a specific, group or all
/// resources that component has access to. Its destination address is
/// global and it should be responded to with a iHave message if the component
/// determines it has details of the requested resource.
///
/// 2. iHave - This message is genertaed by Dartivity suite components
/// in response to a whoHas message if they have, or can obtain details of
/// the resource being requested. The destination of the message should be
/// set to the source field of the whoHas message with the resource payload
/// itself being provider specific.
///
part of dartivity_messaging;

/// Message types
enum MessageType { whoHas, iHave, resourceDetails, clientInfo, unknown }

class DartivityMessage {
  DartivityMessage.whoHas(String? source, String? resourceName,
      [String? host = "", bool refreshCache = false]) {
    if ((source == null) || (resourceName == null) || (host == null)) {
      throw new DartivityMessagingException(
          DartivityMessagingException.invalidWhohasMessage);
    }
    _type = MessageType.whoHas;
    _source = source;
    _destination = addressGlobal;
    _resourceName = resourceName;
    _host = host;
    _refreshCache = refreshCache;
  }

  DartivityMessage.iHave(String? source, String? destination, String? resourceName,
      Map<String, dynamic>? resourceDetails, String? host, String? provider) {
    if ((source == null) ||
        (resourceDetails == null) ||
        (destination == null) ||
        (resourceName == null) ||
        (host == null) ||
        (provider == null)) {
      throw new DartivityMessagingException(
          DartivityMessagingException.invalidIhaveMessage);
    }
    _type = MessageType.iHave;
    _source = source;
    _destination = destination;
    _resourceName = resourceName;
    _resourceDetails = resourceDetails;
    _host = host;
    _provider = provider;
  }

  /// fromJson
  DartivityMessage.fromJSON(String input) {
    if (input == null) {
      _type = MessageType.unknown;
    } else {
      final jsonobject.JsonObjectLite jsonobj =
          new jsonobject.JsonObjectLite.fromJsonString(input);
      final List<MessageType> types = MessageType.values;
      _type = types[(jsonobj as dynamic).type];
      _host = jsonobj['host'] = (jsonobj as dynamic).host;
      _provider = jsonobj['provider'] = (jsonobj as dynamic).provider;
      _source = jsonobj['source'] = (jsonobj as dynamic).source;
      _destination = jsonobj['destination'] = (jsonobj as dynamic).destination;
      _resourceName =
          jsonobj['resourceName'] = (jsonobj as dynamic).resourceName;
      _resourceDetails =
          jsonobj['resourceDetails'] = (jsonobj as dynamic).resourceDetails;
      _refreshCache =
          jsonobj['refreshCache'] = (jsonobj as dynamic).refreshCache;
    }
  }

  /// fromJsonObject
  DartivityMessage.fromJSONObject(dynamic input) {
    if (input == null) {
      _type = MessageType.unknown;
    } else {
      final List<MessageType> types = MessageType.values;
      _type = types[input.type];
      _source = input.source;
      _destination = input.destination;
      _resourceName = input.resourceName;
      _resourceDetails =
          Map<String, dynamic>.fromIterable(input.resourceDetails.toIterable());
      _host = input.host;
      _provider = input.provider;
      _refreshCache = input.refreshCache;
    }
  }

  /// Type
  MessageType _type = MessageType.unknown;

  MessageType get type => _type;

  /// Dartivity source
  String? _source = "";

  String? get source => _source;

  /// Dartivity Destination
  String? _destination = "";

  String? get destination => _destination;

  // Source/destination constants
  static const String addressGlobal = "global";
  static const String addressWebServer = "web-server";

  /// Resource name, also known as the resource Uri
  String? _resourceName = "";

  String? get resourceName => _resourceName;

  /// Resource host
  String? _host = "";

  String? get host => _host;

  /// Provider , eg Iotivity
  static const String providerUnknown = "Unknown";
  static const String providerIotivity = "Iotivity";
  String? _provider = providerUnknown;

  String? get provider => _provider;

  /// Resource details
  Map<String, dynamic>? _resourceDetails = {};

  /// Invalidate cache instruction to clients, causes co-operating
  /// clients to refresh local caches for the current whoHas message.
  /// Advisory only, clients can ignore this if they wish.
  bool? _refreshCache = false;

  bool? get refreshCache => _refreshCache;

  Map<String, dynamic>? get resourceDetails => _resourceDetails;

  /// toJSON
  String toJSON() {
    final dynamic output = new jsonobject.JsonObjectLite();
    output.type = type.index;
    output.source = _source;
    output.destination = _destination;
    output.resourceName = _resourceName;
    output.resourceDetails = _resourceDetails;
    output.host = _host;
    output.provider = _provider;
    output.refreshCache = _refreshCache;

    return output.toString();
  }

  /// toString
  String toString() {
    return "Type : ${type}, Provider : ${provider}, Host : ${host}, Source : ${source}, Destination : ${destination}, Resource Name : ${resourceName}, Resource Details : ${resourceDetails.toString()}";
  }

  /// equals ovverride
  bool operator ==(dynamic other) {
    if (other is DartivityMessage) {
      bool state = false;
      this.resourceName == other.resourceName ? state = true : null;
      return state;
    } else {
      return false;
    }
  }

  int get hashCode => resourceName.hashCode;
}
