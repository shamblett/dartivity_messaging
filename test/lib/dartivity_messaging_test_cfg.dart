/*
 * Package : dartivity_messaging.test
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 27/11/2015
 * Copyright :  S.Hamblett 2015
 */

/// Package name
const String messPackageName = 'dartivity';

/// Pubsub project id
const String messProjectId = 'warm-actor-356';

/// Topic for pubsub
const String messTopic =
    "projects/${messProjectId}/topics/${messPackageName}_test";

const String messCredPath =
    '\\test\\lib\\credentials\\Development-5d8666050474.json';

/// Client id's
const String clientId1 = 'dell-base-d5dcb860-3ad8-5329-ab54-5c3c9c5f2242%100';
const String clientId2 = 'dell-base-d5dcb860-3ad8-5329-ab54-5c3c9c5f2242%200';
