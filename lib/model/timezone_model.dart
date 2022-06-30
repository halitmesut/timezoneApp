// To parse this JSON data, do
//
//     final timezoneModel = timezoneModelFromJson(jsonString);

import 'dart:convert';

TimezoneModel timezoneModelFromJson(String str) =>
    TimezoneModel.fromJson(json.decode(str));

String timezoneModelToJson(TimezoneModel data) => json.encode(data.toJson());

class TimezoneModel {
  TimezoneModel({
    this.datetime,
    this.timezone,
    this.utcDatetime,
    this.utcOffset,
  });

  DateTime? datetime;
  String? timezone;
  DateTime? utcDatetime;
  String? utcOffset;

  factory TimezoneModel.fromJson(Map<String, dynamic> json) => TimezoneModel(
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        timezone: json["timezone"] == null ? null : json["timezone"],
        utcDatetime: json["utc_datetime"] == null
            ? null
            : DateTime.parse(json["utc_datetime"]),
        utcOffset: json["utc_offset"] == null ? null : json["utc_offset"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime == null ? null : datetime?.toIso8601String(),
        "timezone": timezone == null ? null : timezone,
        "utc_datetime":
            utcDatetime == null ? null : utcDatetime?.toIso8601String(),
        "utc_offset": utcOffset == null ? null : utcOffset,
      };
}
