import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ssc/domain/model/customer/social_media.dart';
import 'package:ssc/infrastructure/social_media/repository/customer_sign_up_repository.dart';

part 'social_media_event.dart';
part 'social_media_state.dart';

class SocialMediaBloc extends Bloc<SocialMediaEvent, SocialMediaState> {
  SocialMediaRepository socialMediaRepository;
  SocialMediaBloc({required this.socialMediaRepository})
      : super(SocialMediaState.initial()) {
    on<SocialMediaInitialEvent>(
      (event, emit) => emit(SocialMediaState.initial()),
    );
    on<SocialMediaFetchEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
      ));
      final failureOrSuccessOption =
          await socialMediaRepository.getSocialMediaUrls();

      failureOrSuccessOption.fold(
        (failure) {
          emit(state.copyWith(
            apiFailureOrSuccessOption: optionOf(Left(failure)),
            isLoading: false,
          ));
        },
        (socialMedia) {
          emit(
            state.copyWith(
              apiFailureOrSuccessOption: optionOf(Right(socialMedia)),
              isLoading: false,
              socialMedia: socialMedia,
            ),
          );
        },
      );
    });
  }
}
