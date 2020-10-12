part of 'court_booking_cubit.dart';

@immutable
abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

class ScheduleValidating extends ScheduleState {
  const ScheduleValidating();
}

class ScheduleValidationSucceed extends ScheduleState {
  const ScheduleValidationSucceed();
}

class ScheduleValidationFailed extends ScheduleState {
  const ScheduleValidationFailed();
}

class ScheduleLoaded extends ScheduleState {
  final ScheduleModel schedule;
  const ScheduleLoaded(this.schedule);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ScheduleLoaded && o.schedule == schedule;
  }

  @override
  int get hashCode => schedule.hashCode;
}

class ScheduleError extends ScheduleState {
  final String message;
  const ScheduleError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ScheduleError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
