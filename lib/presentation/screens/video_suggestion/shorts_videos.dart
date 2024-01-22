import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/ads/ads.dart';

class ShortVideos extends StatefulWidget {
  const ShortVideos({Key? key}) : super(key: key);

  @override
  State<ShortVideos> createState() => _ShortVideosState();
}

class _ShortVideosState extends State<ShortVideos> {
  List<String> videoIds = [
    "j4ovKnpMJRA",
    "BYxpW7PPKRw",
    "1KvkDCmDwK8",
    "Dz0frmjv1Mw",
    "OL16129Qayg",
    "nOwdfAC89Z0",
    "4nLap3f729U",
    "ORrepRouHLM",
    "iYTxAfymCn0",
    "mlB2k8Z0dXw",
    "fVJ-CK2W1HQ",
    "Yn62LbbN4fA",
    "2QZUJBGfY4s",
    "eojdMQjZfeU",
    "bhxL58ezHJ8",
    "WYF0v7itMl4",
    "OfCfZHbeD_k",
    "BssmH0dW0-E",
    "23ycQ-r1zCc",
    "LtKrmKlbcBs",
    "29DXrS0bBcU",
    "oiAcCRtiM3s",
    "K7USVFczhow",
    "M-TS9NZRdn0",
    "UoxJl2QgfK0",
    "X_eyw9AWm9g",
    "f65wyUWOyPM",
    "6aGQJduanF4",
    "ghXo5bJ81zE",
    "eV_3_KcDj4o",
  ];

  int currentVideoIndex = 0;
  late YoutubePlayerController _controller;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller and set video options

    _controller = YoutubePlayerController(
      initialVideoId: videoIds[currentVideoIndex],
      flags: const YoutubePlayerFlags(
        loop: true,
        mute: false,
        autoPlay: true,
        forceHD: false,
        controlsVisibleAtStart: false,
        isLive: false,
        hideControls: true,
        useHybridComposition: true,
      ),
    )..addListener(_videoListener);
    Ads().showInterstitialAd();
  }

  void _videoListener() {
    if (_controller.value.isReady && !_controller.value.isFullScreen) {
      setState(() {
        // Pause other videos and play the current one
        for (int i = 0; i < videoIds.length; i++) {
          if (i != currentVideoIndex) {
            YoutubePlayerController(initialVideoId: videoIds[i]).pause();
          }
        }
      });
    }
  }

  void _playNextVideo() {
    if (currentVideoIndex < videoIds.length - 1) {
      setState(() {
        currentVideoIndex++;
        isPaused = false;
      });
    } else {
      // If we're at the last video, go back to the first video
      setState(() {
        currentVideoIndex = 0;
        isPaused = false;
      });
    }
    // Load and play the new video
    _controller.load(videoIds[currentVideoIndex]);
    _controller.play();
  }

  void _playPreviousVideo() {
    if (currentVideoIndex > 0) {
      setState(() {
        currentVideoIndex--;
        isPaused = false;
      });
    } else {
      // If we're at the first video, go to the last video
      setState(() {
        currentVideoIndex = videoIds.length - 1;
        isPaused = false;
      });
    }
    // Load and play the new video
    _controller.load(videoIds[currentVideoIndex]);
    _controller.play();
  }

  void _togglePause() {
    if (isPaused) {
      _controller.play();
    } else {
      _controller.pause();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // Swipe down

                  _playNextVideo();
                } else if (details.primaryVelocity! < 0) {
                  // Swipe up
                  _playPreviousVideo();
                }
              },
              onTap: _togglePause,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    Ads.rewardedAd?.dispose();
  }
}
