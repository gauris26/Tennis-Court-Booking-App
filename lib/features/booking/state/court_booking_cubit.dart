import 'package:tennis_court_reservation/draft/entity/court.dart';
import 'package:tennis_court_reservation/draft/repository/court_repository.dart';
import 'package:tennis_court_reservation/draft/entity/schedule.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'court_booking_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final CourtRepository _courtRepository;
  ScheduleCubit(this._courtRepository) : super(ScheduleInitial());

  ValueListenable<Box<ScheduleModel>> getSchedules() => _courtRepository.getSchedulesListenable();

  ValueListenable<Box<CourtModel>> getCourts() => _courtRepository.getCourtsListenable();

  int getCourtState(int id) => _courtRepository.getCourtState(id);

  bool isDateTimeAvailable(int id, DateTime dateTime) => _courtRepository.isDateTimeAvailable(id, dateTime);

  void saveSchedule(ScheduleModel schedule) => _courtRepository.saveSchedule(schedule);
}
