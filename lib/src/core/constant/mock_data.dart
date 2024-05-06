import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';
import 'package:flutter/material.dart';

abstract class MockData {
  static List<Rooms> getRooms() {
    final imageList = [
      PngAssetPath.roomExample1,
      PngAssetPath.roomExample2,
      PngAssetPath.roomExample3,
    ];
    imageList.shuffle();
    final imageList1 = [...imageList];
    imageList.shuffle();
    final imageList2 = [...imageList];
    imageList.shuffle();
    final imageList3 = [...imageList];
    imageList.shuffle();
    final imageList4 = [...imageList];
    imageList.shuffle();
    final imageList5 = [...imageList];
    final rooms = <Rooms>[
      Rooms(
        id: '1',
        square: 300,
        city: 'Башакшехир',
        openTime: TimeOfDay(hour: 9, minute: 0),
        duration: Duration(hours: 12),
        imagesPath: imageList1,
      ),
      Rooms(
        id: '2',
        square: 230,
        city: 'Башакшехир',
        openTime: TimeOfDay(hour: 9, minute: 0),
        duration: Duration(hours: 10),
        imagesPath: imageList2,
      ),
      Rooms(
        id: '3',
        square: 195,
        city: 'Башакшехир',
        openTime: TimeOfDay(hour: 9, minute: 0),
        duration: Duration(hours: 9),
        imagesPath: imageList3,
      ),
      Rooms(
        id: '4',
        square: 330,
        city: 'Башакшехир',
        openTime: TimeOfDay(hour: 9, minute: 0),
        duration: Duration(hours: 13),
        imagesPath: imageList4,
      ),
      Rooms(
        id: '5',
        square: 270,
        city: 'Башакшехир',
        openTime: TimeOfDay(hour: 8, minute: 0),
        duration: Duration(hours: 10),
        imagesPath: imageList5,
      ),
    ];

    return rooms;
  }
}
