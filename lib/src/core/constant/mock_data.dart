import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/feature/country_list/model/country_dto.dart';
import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';

abstract class MockData {
  static List<CountryDto> getCountries() {
    final countries = <CountryDto>[
      CountryDto(
        id: '1',
        name: 'Cтамбул',
        imagePath: CitiesImages.istanbul,
      ),
      CountryDto(
        id: '2',
        name: 'Москва',
        imagePath: CitiesImages.moscow,
      ),
    ];
    return countries;
  }

  static List<Rooms> getRooms({required String cityId}) {
    return coworkings.where((coworking) => coworking.cityId == cityId).toList();
  }

  static Rooms getCoworkingDetails(String coworkingId) {
    return MockData.coworkings
        .firstWhere((coworking) => coworking.id == coworkingId);
  }

  static String getImageForRoomFromId(String id) {
    return switch (id) {
      '1' => Room1Images.roomExample2,
      '2' => Room2Images.roomDetail,
      '3' => Room3Images.roomExample1,
      '4' => Room4Images.roomExample5,
      '5' => Room5Images.roomDetail,
      '6' => Room6Images.roomExample1,
      _ => Room2Images.roomDetail,
    };
  }

  static String getDescriptionForRoomFromId(String id) {
    return switch (id) {
      '1' =>
        '''Полностью оборудованный смарт офис - 15 отдельных кабинетов, общее рабочее пространство, кофейня''',
      '2' =>
        '''Полностью оборудованный смарт офис, пользователи офисов имеют полный доступ ко всем общим зонам в ROOMS 1''',
      '3' =>
        '''Полностью оборудованный смарт офис расположенный в развивающемся районе Стамбула''',
      '4' =>
        '''Полностью оборудованный смарт офис, пользователи офисов имеют полный доступ ко всем общим зонам в ROOMS 1''',
      '5' =>
        '''Полностью оборудованный смарт офис общей площадью 1500 кв.м, находящийся в центре оживленного района Стамбула''',
      '6' =>
        '''Полностью оборудованный смарт офис, общей площадью 500 кв.м, находящийся в деловом центре Стамбула''',
      _ => '',
    };
  }

  static String getUrlForRoomTourFromId(String id) {
    return switch (id) {
      '1' => 'https://my.matterport.com/show/?m=iTMPxVdjPFm&ts=1',
      '2' => 'https://my.matterport.com/show/?m=sGHkciiW1P5&ts=1',
      '3' => 'https://matterport.com/discover/space/9BjtN8oppRH',
      '4' => 'https://my.matterport.com/show/?m=DYbPTp3j5yQ',
      '5' => 'https://my.matterport.com/show/?m=PXpT4UMebLk',
      '6' => 'https://my.matterport.com/show/?m=VpXFapW24tP',
      _ => '',
    };
  }

  static List<String> getIncludedAdvantagesForRoomFromId(String id) {
    return switch (id) {
      '1' => [
          'Переговорные комнаты',
          'Кабинки для zoom звонков',
          'Юридический и почтовый адрес',
          'Терраса с рабочими местами',
          'Чай/кофе/вода/кухонная зона',
          'Зоны отдыха',
          'Высокоскоростной интернет'
        ],
      '2' => [
          'Переговорные комнаты',
          'Кабинки для zoom звонков',
          'Юридический и почтовый адрес',
          'Чай/кофе/вода/кухонная зона',
          'Высокоскоростной интернет'
        ],
      '3' => [
          'Конференц-зал',
          'Переговорные комнаты',
          'Помещение для конференций',
          'Видео и аудио студия',
          'Зоны отдыха, кухонная зона',
          'Мансарда с рабочей зоной',
          'Высокоскоростной интернет'
        ],
      '4' => [
          'Конференц-зал',
          'Переговорные комнаты',
          'Кабинки для zoom звонков',
          'Юридический и почтовая ячейка',
          'Чай/кофе/вода/кухня',
          'Зоны отдыха',
        ],
      '5' => [
          'Конференц-зал',
          'Переговорные комнаты',
          'Кабинки для zoom звонков',
          'Юридический и почтовая ячейка',
          'Чай/кофе/вода/кухня',
          'Терраса с рабочими местами',
          'Зоны отдыха',
        ],
      '6' => [
          'Конференц-зал',
          'Переговорные комнаты',
          'Кабинки для zoom звонков',
          'Юридический и почтовая ячейка',
          'Чай/кофе/вода/кухня',
          'Терраса с рабочими местами',
          'Зоны отдыха',
        ],
      _ => [],
    };
  }

  static final List<Rooms> coworkings = [
    Rooms(
      id: '1',
      cityId: '1',
      square: 900,
      city: 'Başakşehir',
      imagesPath: [
        Room1Images.roomExample1,
        Room1Images.roomExample2,
        Room1Images.roomExample3,
        Room1Images.roomExample4,
        Room1Images.roomExample5,
        Room1Images.roomExample6,
      ],
    ),
    Rooms(
      id: '2',
      cityId: '1',
      square: 110,
      city: 'Başakşehir',
      imagesPath: [
        Room2Images.roomExample1,
        Room2Images.roomExample2,
        Room2Images.roomExample3,
        Room2Images.roomExample4,
        Room2Images.roomExample5,
      ],
    ),
    Rooms(
      id: '3',
      cityId: '1',
      square: 500,
      city: 'Başakşehir',
      imagesPath: [
        Room3Images.roomExample1,
        Room3Images.roomExample2,
        Room3Images.roomExample3,
        Room3Images.roomExample4,
        Room3Images.roomExample5,
        Room3Images.roomExample6,
      ],
    ),
    Rooms(
      id: '4',
      cityId: '1',
      square: 140,
      city: 'Başakşehir',
      imagesPath: [
        Room4Images.roomExample1,
        Room4Images.roomExample2,
        Room4Images.roomExample3,
        Room4Images.roomExample4,
        Room4Images.roomExample5,
        Room4Images.roomExample6,
      ],
    ),
    Rooms(
      id: '5',
      cityId: '1',
      square: 1500,
      city: 'BEYLİKDÜZÜ',
      imagesPath: [
        Room5Images.roomExample1,
        Room5Images.roomExample2,
        Room5Images.roomExample3,
        Room5Images.roomExample4,
        Room5Images.roomExample5,
      ],
    ),
    Rooms(
      id: '6',
      cityId: '1',
      square: 500,
      city: 'Maslak',
      imagesPath: [
        Room6Images.roomExample1,
        Room6Images.roomExample2,
        Room6Images.roomExample3,
        Room6Images.roomExample4,
        Room6Images.roomExample5,
      ],
    ),
  ];
}
