/*
 Created by Thanh Son on 30/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:nts_picker/data/model/data/preview_data.model.dart';
import 'package:nts_picker/data/model/data/video_data.model.dart';
import 'package:nts_picker/helper/time_duration.dart';
import 'package:nts_picker/manager/video_data_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../image_error_view.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({Key? key, required this.data}) : super(key: key);

  final UIPreviewData data;

  @override
  State<StatefulWidget> createState() {
    return _VideoPreview();
  }
}

class _VideoPreview extends State<VideoPreview> {
  final Completer<void> _completer = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    if (data.checker) {
      return FutureBuilder<void>(
          future: _completer.future,
          builder: (context, snapshot) {
            var videoData = VideoDataManager.instance.getData(data.file);
            if (videoData != null) {
              return Stack(fit: StackFit.expand, children: [
                videoData.data == null
                    ? const ErrorView()
                    : Image.memory(
                        videoData.data!,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          if (kDebugMode) {
                            log('image error', error: error);
                          }
                          return const ErrorView();
                        },
                      ),
                Visibility(
                  visible: data.file.selected,
                  child: Container(color: Colors.black45),
                ),
                Center(
                  child: Visibility(
                      visible: data.file.selected,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 32,
                      )),
                ),
                Positioned(
                    bottom: 5,
                    left: 5,
                    child: Text(
                      millisToString(videoData.info?.duration ?? 0),
                      style: Theme.of(context).textTheme.bodyText1!.apply(
                        color: Colors.white,
                        shadows: <Shadow>[
                          const Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 3.0,
                            color: Colors.black45,
                          ),
                          const Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 8.0,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    )),
              ]);
            } else {
              return const ErrorView();
            }
          });
    } else {
      return FutureBuilder<void>(
          future: _completer.future,
          builder: (context, snapshot) {
            var videoData = VideoDataManager.instance.getData(data.file);
            if (videoData != null) {
              return Stack(fit: StackFit.expand, children: [
                videoData.data == null
                    ? const ErrorView()
                    : Image.memory(
                        videoData.data!,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          if (kDebugMode) {
                            log('image error', error: error);
                          }
                          return const ErrorView();
                        },
                      ),
                Positioned(
                    bottom: 5,
                    left: 5,
                    child: Text(
                      millisToString(videoData.info?.duration ?? 0),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .apply(color: Colors.white, shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 3.0,
                          color: Colors.black45,
                        ),
                        const Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                          color: Colors.black45,
                        ),
                      ]),
                    )),
              ]);
            } else {
              return const ErrorView();
            }
          });
    }
  }

  Future<void> getThumbnail() async {
    if (!VideoDataManager.instance.exist(widget.data.file)) {
      final videoInfo = FlutterVideoInfo();

      var info = await videoInfo.getVideoInfo(widget.data.file.path);
      var data = await VideoThumbnail.thumbnailData(
        video: widget.data.file.path,
        imageFormat: ImageFormat.PNG,
        quality: 100,
      );

      var videoData = UIVideoData(info: info, data: data);
      VideoDataManager.instance.putData(widget.data.file, videoData);
      _completer.complete();
    }
  }
}
