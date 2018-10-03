class Artist {
  final String name;
  final int playcount;
  final int listeners;
  final bool isStreamable;
  final String imageUrl;

  Artist(this.name, this.playcount, this.listeners, this.isStreamable,
      this.imageUrl);

  Artist.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        playcount = int.parse(json['playcount']),
        listeners = int.parse(json['listeners']),
        isStreamable = json['streamable'] != "0",
        imageUrl =
            (json['image']).firstWhere((item) {
          return item['size'] == 'large';
        })['#text'];
}
