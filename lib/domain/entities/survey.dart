class Survey {
  const Survey({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });

  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

}
