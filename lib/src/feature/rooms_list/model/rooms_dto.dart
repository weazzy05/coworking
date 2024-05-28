/// Rooms model
class Rooms {
  /// Rooms create
  const Rooms({
    required this.id,
    required this.square,
    required this.city,
    required this.imagesPath,
  });

  /// Rooms id
  final String id;

  /// Rooms square
  final int square;

  /// Rooms city
  final String city;

  /// Rooms images
  final List<String> imagesPath;
}
