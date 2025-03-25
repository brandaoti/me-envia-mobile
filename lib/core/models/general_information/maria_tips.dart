import '../../../../core/helpers/extensions.dart';

typedef MariaTipsList = List<MariaTips>;

class MariaTips {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? media;
  final String? title;
  final String? link;
  final String? description;

  const MariaTips({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
    required this.title,
    required this.link,
    required this.description,
  });

  factory MariaTips.fromJson(Map json) {
    return MariaTips(
      id: json['id'],
      link: json['link'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      media: (json['media'] as String).normalizePictureUrl,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'media': media,
      'title': title,
      'link': link,
      'description': description,
    };
  }
}
