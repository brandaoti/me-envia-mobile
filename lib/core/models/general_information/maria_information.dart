import '../../../../core/helpers/extensions.dart';

class MariaInformation {
  final String id;
  final String title;
  final String subtitle;
  final String text;
  final String picture;

  const MariaInformation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.text,
    required this.picture,
  });

  factory MariaInformation.fromJson(Map json) {
    return MariaInformation(
      id: json['id'],
      text: json['text'],
      title: json['title'],
      subtitle: json['subtitle'],
      picture: (json['picture'] as String).normalizePictureUrl,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'text': text,
      'title': title,
      'picture': picture,
      'subtitle': subtitle,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MariaInformation &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.text == text &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        text.hashCode ^
        picture.hashCode;
  }

  @override
  String toString() {
    return 'MariaInformation(id: $id, title: $title, subtitle: $subtitle, text: $text, picture: $picture)';
  }
}
