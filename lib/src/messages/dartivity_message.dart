/*
 * Package : dartivity_messaging
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

part of dartivity_messaging;

/// Message types
enum MessageType { whoHas, iHave, resourceDetails, clientInfo, unknown }

class DartivityMessage {
  /// Type
  MessageType _type = MessageType.unknown;

  MessageType get type => _type;

  /// Dartivity source
  String _source = "";

  String get source => _source;

  /// Dartivity Destination
  String _destination = "";

  String get destination => _destination;

  // Source/destination constants
  static const ADDRESS_GLOBAL = "global";
  static const ADDRESS_WEB_SERVER = "web-server";

  /// Resource name, also known as the resource Uri
  String _resourceName = "";

  String get resourceName => _resourceName;

  /// Resource host
  String _host = "";

  String get host => _host;

  /// Provider , eg Iotivity
  static const String PROVIDER_UNKNOWN = "Unknown";
  static const String PROVIDER_IOTIVITY = "Iotivity";
  String _provider = PROVIDER_UNKNOWN;

  String get provider => _provider;

  /// Resource details
  Map<String, dynamic> _resourceDetails = {};

  /// Invalidate cache instruction to clients, causes co-operating
  /// clients to refresh local caches for the current whoHas message.
  /// Advisory only, clients can ignore this if they wish.
  bool _refreshCache = false;

  bool get refreshCache => _refreshCache;

  Map<String, dynamic> get resourceDetails => _resourceDetails;

  DartivityMessage.whoHas(String source, String resourceName,
      [String host = "", bool refreshCache = false]) {
    if ((source == null) || (resourceName == null) || (host == null)) {
      throw new DartivityMessagingException(
          DartivityMessagingException.INVALID_WHOHAS_MESSAGE);
    }
    _type = MessageType.whoHas;
    _source = source;
    _destination = ADDRESS_GLOBAL;
    _resourceName = resourceName;
    _host = host;
    _refreshCache = refreshCache;
  }

  DartivityMessage.iHave(String source, String destination, String resourceName,
      Map<String, dynamic> resourceDetails, String host, String provider) {
    if ((source == null) ||
        (resourceDetails == null) ||
        (destination == null) ||
        (resourceName == null) ||
        (host == null) ||
        (provider == null)) {
      throw new DartivityMessagingException(
          DartivityMessagingException.INVALID_IHAVE_MESSAGE);
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
      jsonobject.JsonObject jsonobj =
      new jsonobject.JsonObject.fromJsonString(input);
      List<MessageType> types = MessageType.values;
      _type = jsonobj.containsKey('type')
          ? types[jsonobj.type]
          : MessageType.unknown;
      _host = jsonobj.containsKey('host') ? jsonobj.host : "";
      _provider =
      jsonobj.containsKey('provider') ? jsonobj.provider : PROVIDER_UNKNOWN;
      _source = jsonobj.containsKey('source') ? jsonobj.source : "";
      _destination =
      jsonobj.containsKey('destination') ? jsonobj.destination : "";
      _resourceName =
      jsonobj.containsKey('resourceName') ? jsonobj.resourceName : "";
      _resourceDetails =
      jsonobj.containsKey('resourceDetails') ? jsonobj.resourceDetails : {};
      _refreshCache =
      jsonobj.containsKey('refreshCache') ? jsonobj.refreshCache : false;
    }
  }

  /// fromJsonObject
  DartivityMessage.fromJSONObject(jsonobject.JsonObject input) {
    if (input == null) {
      _type = MessageType.unknown;
    } else {
      List<MessageType> types = MessageType.values;
      _type =
      input.containsKey('type') ? types[input.type] : MessageType.unknown;
      _source = input.containsKey('source') ? input.source : "";
      _destination = input.containsKey('destination') ? input.destination : "";
      _resourceName =
      input.containsKey('resourceName') ? input.resourceName : "";
      _resourceDetails =
      input.containsKey('resourceDetails') ? input.resourceDetails : "{}";
      _host = input.containsKey('host') ? input.host : "";
      _provider =
      input.containsKey('provider') ? input.provider : PROVIDER_UNKNOWN;
      _refreshCache =
      input.containsKey('refreshCache') ? input.refreshCache : false;
    }
  }

  /// toJSON
  String toJSON() {
    jsonobject.JsonObject output = new jsonobject.JsonObject();
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
    return "Type : ${type}, Provider : ${provider}, Host : ${host}, Source : ${source}, Destination : ${destination}, Resource Name : ${resourceName}, Resource Details : ${resourceDetails
        .toString()}";
  }

  /// equals ovverride
  bool operator ==(DartivityMessage other) {
    bool state = false;
    this.resourceName == other.resourceName ? state = true : null;
    return state;
  }
}
