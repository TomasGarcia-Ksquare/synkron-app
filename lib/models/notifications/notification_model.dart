/*
This is a simple class used to represent the notificaions of the employees. 

Review the next...

It has 10 properties:
id: int where the employeer's notification ID is indicated.
updatedAt: String where the last update date is indicated.
createdAt: String where the creation date is indicated.
description: String where the notificacion message is indicated.
type: String where the type of the notification is indicated.
subtype: String where the subtype of the notification is indicated.
requiresAction: bool that indicates if any action is required for this notification.
isRead: bool that indicates if the notification is read.
iconName: String that indicates the notification's icon. 
employeeId: int that indicates employee's ID.
*/
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.description,
    this.type,
    this.subtype,
    this.requiresAction,
    this.isRead,
    this.iconName,
    this.employeeId,
  });

  int? id;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? description;
  String? type;
  String? subtype;
  bool? requiresAction;
  bool? isRead;
  String? iconName;
  int? employeeId;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        description: json["description"],
        type: json["type"],
        subtype: json["subtype"],
        requiresAction: json["requiresAction"],
        isRead: json["isRead"],
        iconName: json["iconName"],
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "description": description,
        "type": type,
        "subtype": subtype,
        "requiresAction": requiresAction,
        "isRead": isRead,
        "iconName": iconName,
        "employeeId": employeeId,
      };
}
