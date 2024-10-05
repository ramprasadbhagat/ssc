// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:ssc/domain/model/service_entity.dart';
// import 'package:ssc/presentation/utils/number_ext.dart';
// import 'package:audioplayers/audioplayers.dart' as ad;
// import 'package:flutter_sound/flutter_sound.dart' as flutter_sound;

// class ServiceDetailPage extends StatefulWidget {
//   final ServiceEntity serviceEntity;
//   const ServiceDetailPage({super.key, required this.serviceEntity});

//   @override
//   State<ServiceDetailPage> createState() => _ServiceDetailPageState();
// }

// class _ServiceDetailPageState extends State<ServiceDetailPage> {
//   final TextEditingController _noteController = TextEditingController();
//   FocusNode _focusNode = FocusNode();
//   final recorder = flutter_sound.FlutterSoundRecorder();
//   bool isRecorderReady = false;

//   //audio player
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   final audioPlayer = ad.AudioPlayer();

//   //audio path
//   File audioPath = File('');
//   bool isAudioRecorded = false;

//   @override
//   void initState() {
//     super.initState();
//     initRecorder();
//     initAudio();
//   }

//   Future<void> initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission is denied';
//     }
//     await recorder.openRecorder();
//     isRecorderReady = true;
//     await recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
//   }

//   Future<void> initAudio() async {
//     //audio listen to state
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == ad.PlayerState.playing;
//       });
//     });

//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });

//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     audioPlayer.dispose();
//     _noteController.dispose();
//     _focusNode.dispose();
//     recorder.closeRecorder();
//     duration = Duration.zero;
//     position = Duration.zero;
//   }

//   Future record() async {
//     if (!isRecorderReady) return;

//     await recorder.startRecorder(toFile: 'audio');
//   }

//   Future stop() async {
//     if (!isRecorderReady) return;
//     final path = await recorder.stopRecorder();
//     audioPath = File(path!);
//     print('recorded audio path : $audioPath');
//     isAudioRecorded = true;
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final twoDigitHour = twoDigits(duration.inHours);
//     final twoDigitMin = twoDigits(duration.inMinutes.remainder(60));
//     final twoDigitSec = twoDigits(duration.inSeconds.remainder(60));

//     return [
//       if (duration.inHours > 0) twoDigitHour,
//       twoDigitMin,
//       twoDigitSec,
//     ].join(':');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Service detail'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.serviceEntity.title,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: 6.0.h,
//               ),
//               TextField(
//                 controller: _noteController,
//                 focusNode: _focusNode,
//                 maxLines: 6,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your request here...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 keyboardType: TextInputType.multiline,
//                 textInputAction: TextInputAction.newline,
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       _focusNode.unfocus();
//                       //TODO: save note here
//                     },
//                     child: const Text('SAVE')),
//               ),
//               SizedBox(height: 20.0.h),
//               const Text(
//                 'Record your request',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 6.0.h),
//               Card(
//                 elevation: 8,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       const Text('We allow you to record your request'),
//                       SizedBox(height: 10.0.h),
//                       StreamBuilder(
//                           stream: recorder.onProgress,
//                           builder: (context, snapshot) {
//                             final duration = snapshot.hasData
//                                 ? snapshot.data!.duration
//                                 : Duration.zero;
//                             return Text(formatTime(duration));
//                           }),
//                       ElevatedButton(
//                           onPressed: () async {
//                             recorder.isRecording
//                                 ? await stop()
//                                 : await record();
//                             if (recorder.isRecording && isAudioRecorded) {
//                               isAudioRecorded = false;
//                               await audioPlayer.stop();
//                             }
//                             setState(() {});
//                           },
//                           child: Icon(
//                               recorder.isRecording ? Icons.stop : Icons.mic)),
//                       if (isAudioRecorded) ...[
//                         Slider(
//                           value: position.inSeconds.toDouble(),
//                           onChanged: (value) async {
//                             final position = Duration(seconds: value.toInt());
//                             await audioPlayer.seek(position);

//                             await audioPlayer.resume();
//                           },
//                           min: 0,
//                           max: duration.inSeconds.toDouble(),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(formatTime(position)),
//                               Text(formatTime(duration)),
//                             ],
//                           ),
//                         ),
//                         CircleAvatar(
//                           radius: 30,
//                           child: IconButton(
//                             icon: Icon(
//                                 isPlaying ? Icons.pause : Icons.play_arrow),
//                             onPressed: () async {
//                               if (isPlaying) {
//                                 await audioPlayer.pause();
//                               } else {
//                                 await audioPlayer.setSource(
//                                   ad.UrlSource(audioPath.path),
//                                 );
//                                 await audioPlayer
//                                     .play(ad.UrlSource(audioPath.path));
//                               }
//                             },
//                             iconSize: 30,
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () async {
//                               isAudioRecorded = false;
//                               isPlaying = false;
//                               recorder.updateRecorderProgress(duration: 0);
//                               await audioPlayer.stop();
//                               setState(() {});
//                             },
//                           ),
//                         )
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
              
//               SizedBox(height: 20.0.h),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     String note = _noteController.text;
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Note saved: $note')),
//                     );
//                   },
//                   child: const Text('Submit request'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
