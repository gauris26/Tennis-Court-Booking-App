import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tennis_court_reservation/features/booking/infrastructure/repository/court_repository.dart';
import 'core/box_mock.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/schedule.dart';
import 'package:hive/hive.dart';
import 'features/booking/domain/entities/schedule_mock.dart';
import 'features/booking/domain/entities/court_mock.dart';

void main() {
  var getIt = GetIt.instance;

  CourtRepository courtRepository;
  BoxMock<ScheduleModelMock> scheduleBox;
  setUp(() {
    courtRepository = CourtRepository();
    scheduleBox = BoxMock<ScheduleModelMock>();

    //getIt.registerSingleton<CourtRepository>(courtRepository);
    getIt.registerSingleton<Box<ScheduleModel>>(scheduleBox);
  });

  group('Booking Rules & Validation', () {
    var schedule1 = ScheduleModelMock();
    var schedule2 = ScheduleModelMock();

    var court = CourtModelMock();

    test("Is Date Available", () async {
      //Given
      var courtId = 1;
      var selectedDateByUser = DateTime(2020, 10, 12, 11, 44);
      var alreadyBookedDateStart = DateTime(2020, 10, 12, 11, 44);
      var alreadyBookedDateEnd = alreadyBookedDateStart.add(Duration(minutes: 30));

      var scheduleList = [schedule1, schedule2];

      //When
      when(scheduleBox.values).thenReturn(scheduleList);

      when(schedule1.court).thenReturn(court);
      when(schedule2.court).thenReturn(court);

      when(court.id).thenReturn(1);
      when(court.id).thenReturn(1);

      when(schedule1.start).thenAnswer((invocation) => alreadyBookedDateStart);
      when(schedule2.start).thenAnswer((invocation) => alreadyBookedDateStart.add(Duration(minutes: 5)));

      when(schedule1.end).thenReturn(alreadyBookedDateEnd);
      when(schedule2.end).thenAnswer((invocation) => alreadyBookedDateEnd.add(Duration(minutes: 8)));

      //Then
      expect(courtRepository.isDateTimeAvailable(courtId, selectedDateByUser), isFalse);
    });

    test("Get Court State - How Many Courts are booked today", () async {
      //Given
      var courtId = 1;
      var alreadyBookedDateStart1 = DateTime(2020, 10, 12, 17, 44);
      var alreadyBookedDateStart2 = DateTime(2020, 10, 18, 17, 44);

      var scheduleList = [schedule1, schedule2];

      //When
      when(scheduleBox.values).thenReturn(scheduleList);

      when(schedule1.court).thenReturn(court);
      when(schedule2.court).thenReturn(court);

      when(court.id).thenReturn(1);
      when(court.id).thenReturn(1);

      when(schedule1.start).thenAnswer((invocation) => alreadyBookedDateStart1);
      when(schedule2.start).thenAnswer((invocation) => alreadyBookedDateStart2.add(Duration(minutes: 5)));

      //Then
      expect(courtRepository.getCourtState(courtId), equals(1));
    });
  });
}
