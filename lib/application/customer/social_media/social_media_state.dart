part of 'social_media_bloc.dart';



class SocialMediaState {
  final bool isRecording;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final SocialMedia socialMedia;
  final Option<Either<String, SocialMedia>> apiFailureOrSuccessOption;

  final List<dynamic> recordings;

  SocialMediaState({
    required this.isRecording,
    required this.isLoading,
    required this.recordings,
    required this.isError,
    required this.isSuccess,
    required this.socialMedia,
    required this.apiFailureOrSuccessOption,
  });

  factory SocialMediaState.initial() {
    return SocialMediaState(
      isRecording: false,
      isLoading: false,
      recordings: [],
      isError: false,
      isSuccess: false,
      socialMedia: SocialMedia.empty(),
      apiFailureOrSuccessOption: none(),
    );
  }

  SocialMediaState copyWith({
    bool? isRecording,
    bool? isLoading,
    List<dynamic>? recordings,
    SocialMedia? socialMedia,
    bool? isError,
    bool? isSuccess,
    Option<Either<String, SocialMedia>>? apiFailureOrSuccessOption,
  }) {
    return SocialMediaState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      recordings: recordings ?? this.recordings,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      socialMedia: socialMedia ?? this.socialMedia,
      apiFailureOrSuccessOption: apiFailureOrSuccessOption ?? this.apiFailureOrSuccessOption,
    );
  }
}
