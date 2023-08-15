import 'package:equatable/equatable.dart';

class Survey extends Equatable {
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
  
  @override
  List<Object?> get props => [ id, question, date, didAnswer ];

}
