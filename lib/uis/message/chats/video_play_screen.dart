import 'dart:developer';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/message/chats/controller/group_chat_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class VideoPlayScreen extends StatefulWidget {
  VideoPlayScreen({super.key});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  final GroupChatController controller = Get.find<GroupChatController>();

  late CachedVideoPlayerPlusController videoController;

  @override
  void initState() {
    super.initState();
    final url = Get.arguments;
    log('url == ${url}');
    videoController = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(url),
        invalidateCacheIfOlderThan: const Duration(days: 1),
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((value) async {
      await videoController.setLooping(false);
      videoController.play();

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }


  void _togglePlayPause() {
    setState(() {
      videoController.value.isPlaying ? videoController.pause() : videoController.play();
    });
  }

  void _seekForward() {
    final currentPosition = videoController.value.position;
    final duration = videoController.value.duration;
    if (currentPosition != duration) {
      videoController.seekTo(
        currentPosition + Duration(seconds: 10),
      );
    }
  }

  void _seekBackward() {
    final currentPosition = videoController.value.position;
    if (currentPosition != Duration.zero) {
      videoController.seekTo(
        currentPosition - Duration(seconds: 10),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrBlacke,
      body: SafeArea(
          child: videoController.value.isInitialized
              ? Column(
            children: [
              AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: CachedVideoPlayerPlus(videoController),
              ),
              ControlsOverlay(
                controller: videoController,
                onPlayPause: _togglePlayPause,
                onSeekForward: _seekForward,
                onSeekBackward: _seekBackward,
              ),
            ],
          ) : Center(child: CommonUi.scaffoldLoading(color: clrYellow))
      ),
    );
  }
}

class ControlsOverlay extends StatelessWidget {
  final CachedVideoPlayerPlusController controller;
  final VoidCallback onPlayPause;
  final VoidCallback onSeekForward;
  final VoidCallback onSeekBackward;

  ControlsOverlay({
    required this.controller,
    required this.onPlayPause,
    required this.onSeekForward,
    required this.onSeekBackward,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPause,
      child: Container(
        color: Colors.black45,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white),
              onPressed: onPlayPause,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.replay_10, color: Colors.white),
                  onPressed: onSeekBackward,
                ),
                IconButton(
                  icon: Icon(Icons.forward_10, color: Colors.white),
                  onPressed: onSeekForward,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

