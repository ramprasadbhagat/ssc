import 'dart:io';

class ServiceEntity {
  final String serviceId;
  final String title;
  final String description;
  final String status;
  final String requestedNote;
  final File videoFile;

  ServiceEntity({
    required this.title,
    required this.description,
    this.status = 'Todo',
    File? videoFile,
    this.requestedNote = '',
    required this.serviceId,
  }) : videoFile = videoFile ?? File('');

  factory  ServiceEntity.empty() => ServiceEntity(
    title: '',
    description: '',
    requestedNote: '',
    status: '',
    videoFile: File(''),
    serviceId: ''
  );

  copyWith({
    String? title,
    String? description,
    String? status,
    String? requestedNote,
    File? videoFile,
    String? serviceId,
  }) =>
      ServiceEntity(
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        requestedNote: requestedNote ?? this.requestedNote,
        videoFile: videoFile ?? this.videoFile,
        serviceId: serviceId ?? this.serviceId,
      );

  factory ServiceEntity.fromMap(Map<String, dynamic> map) {
    return ServiceEntity.empty().copyWith(
      title: map['productName'] ?? '',
      description: map['description'] ?? '',
      serviceId: map['productId'] ?? '',
      status: 'Todo',
    );
  }

  // Method to convert a User to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'videoFile': videoFile,
      'requestedNote': requestedNote,
      'productId' : serviceId,
    };
  }
}
