/*
This is a simple class used to represent the response of a web service. It has 3 properties:
success: a bool indicating whether the service call was successful or not
message: a String representing an optional message that may come with the service response
data: an Object representing the data returned by the service call.

The required keyword used in the constructor parameters indicates that those properties need
 to be passed when creating an instance of the class.
*/

class WsResponse {
  final bool success;
  final String? message;
  final Object? data;

  Object? limit;

  WsResponse({required this.success, this.message, this.data});
}
