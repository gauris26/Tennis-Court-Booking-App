import 'package:tennis_court_reservation/features/booking/domain/entities/court.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/schedule.dart';
import 'package:flutter/foundation.dart';
import '../domain/interfaces/i_court_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'court_booking_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ICourtRepository _courtRepository;
  ScheduleCubit(this._courtRepository) : super(ScheduleInitial());

  ValueListenable<Box<ScheduleModel>> getSchedules() => _courtRepository.getSchedules<ScheduleModel>();

  ValueListenable<Box<CourtModel>> getCourts() => _courtRepository.getSchedules<CourtModel>();

  int getCourtState(int id) => _courtRepository.getCourtState(id);

  bool isDateTimeAvailable(int id, DateTime dateTime) => _courtRepository.isDateTimeAvailable(id, dateTime);

  void saveSchedule(ScheduleModel schedule) => _courtRepository.saveSchedule(schedule);
}
