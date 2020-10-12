import 'package:mockito/mockito.dart';

class DateTimeMock extends Mock implements DateTime {
  DateTime toMockDateTime;
  DateTimeMock(this.toMockDateTime);
  @override
  int get year => toMockDateTime.year;

  DateTimeMock.utc(int year, [int month = 1, int day = 1, int hour = 0, int minute = 0, int second = 0, int millisecond = 0, int microsecond = 0]);
}
