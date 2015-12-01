# dartivity_messaging

The messaging component of the Dartivity IOT suite.

This component provides the interface to Google's pub/sub service using the
Dartivity Message class. This is a simple interface that can be used by any
Dartivity components to perform the messaging function, such as Dartivty clients,
and Dartivity messaging only clients.

The component can also be used as a Dartivity messaging interface in stand
alone bridge applications, e.g from existing dart based IOT packages.

Currently only whoHas and IHave messages are implemented however this will be expanded upon
as the Dartivity suite is expanded.

See the individual classes for more information.