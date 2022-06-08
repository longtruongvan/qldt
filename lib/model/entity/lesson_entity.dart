import 'package:qldt/model/entity/lesson_data.dart';

class LessonEntity {
  final String dayOffWeek;
  final String lesson;
  final List<LessonData> dataLesson;

  const LessonEntity({
    required this.dayOffWeek,
    required this.lesson,
    required this.dataLesson,
  });
}
