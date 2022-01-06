/*
 Created by Thanh Son on 04/01/2022.
 Copyright (c) 2022 . All rights reserved.
*/

enum MediaType {
  image,
  video,
  all,
}

extension MediaTypeX on MediaType {
  String name() {
    switch (this) {
      case MediaType.image:
        return "image";
      case MediaType.video:
        return "video";
      case MediaType.all:
        return "all";
    }
  }

  static MediaType fromJson(String? json) {
    switch (json) {
      case "image":
        return MediaType.image;
      case "video":
        return MediaType.video;
      default:
        return MediaType.all;
    }
  }
}
