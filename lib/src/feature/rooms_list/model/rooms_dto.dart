import 'package:flutter/material.dart';

/// Rooms model
class Rooms {
  /// Rooms create
  const Rooms({
    required this.id,
    required this.square,
    required this.city,
    required this.openTime,
    required this.duration,
    required this.imagesPath,
  });

  /// Rooms id
  final String id;

  /// Rooms square
  final int square;

  /// Rooms city
  final String city;

  /// Rooms openTime
  final TimeOfDay openTime;

  /// Rooms duration
  final Duration duration;

  /// Rooms images
  final List<String> imagesPath;

  String displayWorkingTime() {
    final endTime = openTime.add(duration);
    return '${openTime.duration()}-${endTime.duration()}';
  }
}

extension on TimeOfDay {
  TimeOfDay add(Duration duration) {
    int minutes = this.hour * 60 + this.minute + duration.inMinutes;
    int newHour = minutes ~/ 60 % 24;
    int newMinute = minutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  // Функция для преобразования TimeOfDay в строку формата "часы:минуты"
  String duration() {
    return '${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
  }
}
