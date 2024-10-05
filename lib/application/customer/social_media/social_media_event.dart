part of 'social_media_bloc.dart';

@immutable
sealed class SocialMediaEvent {}
class SocialMediaInitialEvent extends SocialMediaEvent {}
class SocialMediaFetchEvent extends SocialMediaEvent {}

