import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/event.dart';

class EventService {
  static const String protocol = 'https';
  static const String domain = 'fiwis.fiw.fhws.de';
  static const String eventApi = '/fiwis2/api/events';

  Future<List<Event>> getEvents({DateTime? date}) async {
    Uri url;
    if (date == null) {
      url = Uri.https(domain, '$eventApi/today');
    } else {
      final datePart = date.toIso8601String().split('T').first;
      url = Uri.https(domain, eventApi, {'day': datePart});
    }
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Event>((e) => Event.fromJson(e))
          .toList();
    } else {
      throw Exception(
          'Failed to load events due to status code ${response.statusCode}');
    }
  }
}
