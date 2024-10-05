import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/service_detail_request/service_detail_request_bloc.dart';
import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

class VideoRecorderScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  VideoRecorderScreen({required this.cameras});

  @override
  _VideoRecorderScreenState createState() => _VideoRecorderScreenState();
}

class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
  CameraController? _cameraController;
  VideoPlayerController? _videoPlayerController;
  bool _isRecording = false;
  File? _videoFile;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    final serviceDetailRequestState = context.read<ServiceDetailRequestBloc>().state;
    if(serviceDetailRequestState.isVideoFileEmpty){
      _videoFile = null;
    } else{
      setState(() {
        _videoFile = serviceDetailRequestState.serviceEntity.videoFile;
      });
      _playVideo();
    }
    _initializeCamera(_selectedCameraIndex);
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    if (_cameraController != null) {
      await _cameraController?.dispose();
    }
    _cameraController = CameraController(widget.cameras[cameraIndex], ResolutionPreset.high);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController != null) {
      // final directory = await getTemporaryDirectory();
      // final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
      await _cameraController?.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController != null) {
      XFile? videoFile = await _cameraController?.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _videoFile = File(videoFile!.path);
      });
      _playVideo();
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
      _playVideo();
    }
  }

  Future<void> _playVideo() async {
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController?.play();
        });
      _videoPlayerController?.addListener(() {
        if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
          setState(() {
            _videoPlayerController!.seekTo(Duration.zero);
            _videoPlayerController!.pause();
          });
        }
      });
    }
  }

  Future<void> _uploadVideo() async {
    context.read<ServiceDetailRequestBloc>().add(ServiceDetailRequestSetVideoEvent(videoFile: _videoFile ?? File('')));
    if (_videoFile == null) {
      return;
    };
    Navigator.pop(context);
    // final request = http.MultipartRequest('POST', Uri.parse('YOUR_SERVER_URL'));
    // request.files.add(await http.MultipartFile.fromPath('video', _videoFile!.path));
    // final response = await request.send();

    // if (response.statusCode == 200) {
    //   print('Video uploaded successfully');
    // } else {
    //   print('Video upload failed');
    // }
  }

  void _deleteVideo() {
    setState(() {
      _videoFile = null;
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
    });
    if (_cameraController != null) {
      _cameraController?.dispose();
      _initializeCamera(_selectedCameraIndex); // Re-initialize the camera
    }
  }

  void _switchCamera() async {
    if (_isRecording) {
      await _stopRecording();
    }
    _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    await _initializeCamera(_selectedCameraIndex);
    if (_isRecording) {
      await _startRecording();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Video Recorder', style: TextStyle(fontSize: 16),),
        centerTitle: true,
        actions: [
          if (_videoFile != null)
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.upload, color: Colors.purple, size: 36),
                    onPressed: _uploadVideo,
                  ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _deleteVideo,
                ),
              ],
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_cameraController != null && _cameraController!.value.isInitialized)
            SizedBox(
              height: double.infinity,
              child: AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            ),
          if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized)
            Positioned.fill(
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          VideoProgressIndicator(
                            _videoPlayerController!,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: Theme.of(context).colorScheme.inversePrimary,
                              bufferedColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(_videoPlayerController!.value.position),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  _formatDuration(_videoPlayerController!.value.duration),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _videoPlayerController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 36,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _videoPlayerController!.value.isPlaying
                                        ? _videoPlayerController!.pause()
                                        : _videoPlayerController!.play();
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.restart_alt_outlined, size: 36, color: Theme.of(context).colorScheme.inversePrimary,),
                                onPressed: () {
                                  _videoPlayerController!.seekTo(Duration.zero);
                                  _videoPlayerController!.pause();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_videoFile == null)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.video_library, color: Colors.blue, size: 36),
                    onPressed: _pickVideo,
                  ),
                  IconButton(
                    icon: Icon(
                      _isRecording ? Icons.stop : Icons.videocam,
                      color: _isRecording ? Colors.red : Colors.green,
                      size: 36,
                    ),
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                  ),
                  IconButton(
                    icon: Icon(Icons.switch_camera, color: !_isRecording? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.4), size: 36),
                    onPressed: !_isRecording ? _switchCamera : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
