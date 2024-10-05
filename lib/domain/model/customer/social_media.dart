class SocialMedia {
  final int id;
  final String facebookUrl;
  final String youTubeUrl;

  SocialMedia(
      {required this.facebookUrl, required this.youTubeUrl, this.id = -1});

  factory SocialMedia.empty() => SocialMedia(facebookUrl: '', youTubeUrl: '');

  copyWith({
    int? id,
    String? facebookUrl,
    String? youTubeUrl,
  }) {
    return SocialMedia(
        facebookUrl: facebookUrl ?? this.facebookUrl,
        youTubeUrl: youTubeUrl ?? this.youTubeUrl,
        id: id ?? this.id);
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
        facebookUrl: map['facebookUrl'] ?? '',
        youTubeUrl: map['youTubeUrl'] ?? '',
        id: map['id'] ?? -1);
  }
}
