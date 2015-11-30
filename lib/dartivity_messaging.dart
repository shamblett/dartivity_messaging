/*
 * Package : dartivity_messaging
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

library dartivity_messaging;

import 'dart:io';
import 'dart:async';

import 'package:gcloud/pubsub.dart' as pubsub;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:json_object/json_object.dart' as jsonobject;

part 'src/dartivity_messaging.dart';

part 'src/messages/dartivity_message.dart';

part 'src/dartivity_messaging_exception.dart';

