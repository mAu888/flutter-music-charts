class ArtistMetadata {
  final String name;
  final String url;
  final String shortBio;
  final String bio;

  ArtistMetadata({this.name, this.url, this.shortBio, this.bio});

  ArtistMetadata.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        shortBio = json['bio']['summary'].replaceAll(RegExp(r'<([a-zA-Z]+)[^>]*>[^<]*<\/\1>'), ''), // FIXME: There's a link at the end, strip it for now.
        bio = json['bio']['content'];
}
