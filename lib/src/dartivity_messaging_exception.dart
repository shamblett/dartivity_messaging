/*
 * Package : dartivity_messaging
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */
part of dartivity_messaging;

class DartivityMessagingException implements Exception {
  // Exception message strings
  static const String header = 'DartivityMessagingException: ';
  static const String noCredfileSpecified =
      'You must specify a credentials file for messaging';
  static const String noProjectnameSpecified =
      'You must specify a project name for messaging';
  static const String noTopicSpecified =
      'You must specify a topic for messaging';
  static const String invalidWhohasMessage =
      'A whoHas message must have a source and resource id';
  static const String invalidIhaveMessage =
      'A iHave message must have a source, destination, resource id and resource details';
  static const String subscriptionFailed =
      'Failed to create the messaging subscription';
  String? _message = 'No Message Supplied';

  /// Dartivity messaging exception
  DartivityMessagingException([this._message]);

  String toString() => header + "${_message}";
}
