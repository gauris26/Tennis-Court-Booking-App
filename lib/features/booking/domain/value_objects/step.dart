import 'package:flutter/material.dart';

enum TypeTimeline {
  checkpoint,
  line,
}

class StepTimeline {
  StepTimeline(
      {this.type,
      this.hour,
      this.dateTime,
      this.onIndicatorTap,
      this.court,
      this.durationReadable,
      this.message,
      this.duration,
      this.color,
      this.icon,
      this.title});

  final DateTime dateTime;
  final String title;
  final String court;
  final String durationReadable;
  final TypeTimeline type;
  final String hour;
  final String message;
  final int duration;
  final Color color;
  final IconData icon;
  final VoidCallback onIndicatorTap;

  bool get isCheckpoint => type == TypeTimeline.checkpoint;

  bool get hasHour => hour != null && hour.isNotEmpty;
}
