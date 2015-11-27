/*
 * Package : dartivity_messaging
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */
part of dartivity_messaging;

class DartivityMessagingException implements Exception {
  // Exception message strings
  static const HEADER = 'DartivityMessagingException: ';
  static const NO_CREDFILE_SPECIFIED =
      'You must specify a credentials file for messaging';
  static const NO_PROJECTNAME_SPECIFIED =
      'You must specify a project name for messaging';
  static const NO_TOPIC_SPECIFIED = 'You must specify a topic for messaging';
  static const INVALID_WHOHAS_MESSAGE =
      'A whoHas message must have a source and resource id';
  static const INVALID_IHAVE_MESSAGE =
      'A iHave message must have a source, destination, resource id and resource details';
  static const SUBSCRIPTION_FAILED =
      'Failed to create the messaging subscription';
  String _message = 'No Message Supplied';

  /**
   * Dartivity messaging exception
   */
  DartivityMessagingException([this._message]);

  String toString() => HEADER + "${_message}";
}
