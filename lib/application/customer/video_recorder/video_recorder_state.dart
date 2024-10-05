part of 'video_recorder_bloc.dart';

class VideoRecorderState {
  final bool isRecording;
  final bool isLoading;
  final List<dynamic> recordings;
  final String? errorMessage;

  VideoRecorderState({
    required this.isRecording,
    required this.isLoading,
    required this.recordings,
    this.errorMessage,
  });

  factory VideoRecorderState.initial() {
    return VideoRecorderState(
      isRecording: false,
      isLoading: false,
      recordings: [],
      errorMessage: null,
    );
  }

  VideoRecorderState copyWith({
    bool? isRecording,
    bool? isLoading,
    List<dynamic>? recordings,
    String? errorMessage,
  }) {
    return VideoRecorderState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      recordings: recordings ?? this.recordings,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}






