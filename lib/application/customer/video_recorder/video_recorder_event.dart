part of 'video_recorder_bloc.dart';

abstract class VideoRecorderEvent {}

class StartRecording extends VideoRecorderEvent {}

class StopRecording extends VideoRecorderEvent {}

class FetchRecordings extends VideoRecorderEvent {}

class DeleteRecordings extends VideoRecorderEvent {}

