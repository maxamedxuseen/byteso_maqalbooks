// import 'dart:html';
// import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:audioplayers/audioplayers.dart';

class listeningPage extends StatefulWidget {
  String chapter_name;
  String maqal;
  String name;
  String cover;

  listeningPage(this.chapter_name, this.maqal, this.name, this.cover);

  @override
  State<listeningPage> createState() => _listeningPageState();
}

class _listeningPageState extends State<listeningPage> {
  bool isPlaying = false;
  IconData playBtn = Icons.play_arrow;

  late AudioPlayer _player;
  // late AudioCache cache;
  final audioPlayer = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  String _audioUrl = "";
  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.amber,
        inactiveColor: Colors.grey[350],
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    // _player.seek(newPos);
  }

  void _skip(Duration duration) {
    Duration newPosition = position + duration;
    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    } else if (newPosition > duration) {
      newPosition = position + duration;
    }
    audioPlayer.seek(newPosition);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _player = AudioPlayer();
    // cache = AudioCache();
    _audioUrl = widget.maqal;
    // print(_audioUrl);
    audioPlayer.onPlayerStateChanged.listen((State) {
      setState(() {
        isPlaying = State == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // String formatDuration(Duration D) {
  //   var newD = "${D.inHours}:${D.inMinutes}:${D.inSeconds}";
  //   return newD;
  // }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigithour = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigithour:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Future<void> _play() async {
  //   int result = await _player.play(_audioUrl);
  //   if (result == 1) {
  //     setState(() {
  //       isPlaying = true;
  //     });
  //   }
  // }

  // Future<void> _pause() async {
  //   int result = await _player.pause();
  //   if (result == 1) {
  //     setState(() {
  //       isPlaying = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              "MAQAL BOOKS",
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 42, 42, 42),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(20),
                //     bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Color.fromRGBO(239, 206, 106, 1), Colors.amber],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 197, 149, 5),
                    Color.fromARGB(255, 243, 207, 97)
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Waxaad hadda dhageysanosaa ",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 250.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 244, 242, 242)
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(150.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Center(
                      child: Text(
                        widget.chapter_name,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Slider(
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await audioPlayer.seek(position);
                                await audioPlayer.resume();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_formatDuration(position)),
                                  Text(_formatDuration(duration - position)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 45.0,
                                  color: Colors.amber,
                                  onPressed: () {
                                    _skip(Duration(seconds: -10));
                                  },
                                  icon: Icon(Icons.replay_10),
                                ),
                                IconButton(
                                  iconSize: 62.0,
                                  color: Colors.amber,
                                  icon: Icon(isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await audioPlayer.pause();
                                    } else {
                                      String url = _audioUrl;
                                      await audioPlayer.play(UrlSource(url));
                                      // _pause();
                                    }
                                  },
                                ),
                                IconButton(
                                  iconSize: 45.0,
                                  color: Colors.amber,
                                  onPressed: () {
                                    _skip(Duration(seconds: 30));
                                  },
                                  icon: Icon(Icons.forward_30),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
