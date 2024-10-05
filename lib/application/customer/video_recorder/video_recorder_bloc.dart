import 'package:bloc/bloc.dart';

part 'video_recorder_event.dart';
part 'video_recorder_state.dart';

class VideoRecorderBloc extends Bloc<VideoRecorderEvent, VideoRecorderState> {
  VideoRecorderBloc() :super(VideoRecorderState.initial()) {
    on<VideoRecorderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
