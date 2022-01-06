/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/

String millisToString(double durationInMillis) {
  var millis = (durationInMillis % 1000).toInt();
  var second = ((durationInMillis / 1000) % 60).toInt();
  var minute = ((durationInMillis / 1000 ~/ 60)).toInt();
  var realMinute = (minute % 60).toInt();
  var hour = (minute ~/ 60).toInt();

  if (millis > 500) {
    second++;
  }
  if (hour != 0) {
    return '$hour:${realMinute.toString().padLeft(0, '0')}:${second.toString().padLeft(2, '0')}';
  } else {
    return '${realMinute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }
}
