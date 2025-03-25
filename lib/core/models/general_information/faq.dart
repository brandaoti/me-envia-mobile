class Faq {
  final String id;
  final String answer;
  final String question;

  const Faq({
    required this.id,
    required this.answer,
    required this.question,
  });

  factory Faq.fromJson(Map json) {
    return Faq(
      id: json['id'],
      answer: json['answer'],
      question: json['question'],
    );
  }

  Map toMap() {
    return {
      'id': id,
      'answer': answer,
      'question': question,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Faq &&
        other.id == id &&
        other.answer == answer &&
        other.question == question;
  }

  @override
  int get hashCode => id.hashCode ^ answer.hashCode ^ question.hashCode;

  @override
  String toString() => 'Faq(id: $id, answer: $answer, question: $question)';
}
