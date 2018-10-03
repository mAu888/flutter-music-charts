import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Keys {
  Keys();

  Future<String> getApiKey() async {
    final key = await rootBundle.loadStructuredData<String>('keys.json', (string) {
      final Map<String, dynamic> object = json.decode(string);
      return Future<String>.value(object['lastfm_api_key']); 
    });
    return key;
  }
}
