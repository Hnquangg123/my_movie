class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory Video.fromJson(Map<String, dynamic> video) {
    return Video(
      id: video['id'],
      key: video['key'],
      name: video['name'],
      site: video['site'],
      size: video['size'],
      type: video['type'],
    );
  }

  @override
  String toString() {
    return 'Video{id: $id, key: $key, name: $name, site: $site, size: $size, type: $type}';
  }

  bool get isEmpty => id.isEmpty && key.isEmpty;
}
