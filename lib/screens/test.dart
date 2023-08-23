// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioPlayerPage extends StatefulWidget {
//   @override
//   _AudioPlayerPageState createState() => _AudioPlayerPageState();
// }

// class _AudioPlayerPageState extends State<AudioPlayerPage> {
//   late AudioPlayer _audioPlayer;
//   String _audioUrl =
//       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<void> _play() async {
//     int result = await _audioPlayer.play(_audioUrl);
//     if (result == 1) {
//       setState(() {
//         _isPlaying = true;
//       });
//     }
//   }

//   Future<void> _pause() async {
//     int result = await _audioPlayer.pause();
//     if (result == 1) {
//       setState(() {
//         _isPlaying = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//               onPressed: _isPlaying ? _pause : _play,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

