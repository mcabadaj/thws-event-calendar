import 'package:test/test.dart';
import 'package:thws_event_calendar/data/services/event_service.dart';

main() {
  test('Events today', _eventsToday);
  test('Events on 2024-05-10', () => _eventsOnDate('2024-05-10'));
}

_eventsToday() async {
  final events = await EventService().getEvents();
  print('Events today: ${events.length}');
  expect(events.length, greaterThan(0));
}

_eventsOnDate(String date) async {
  final events = await EventService().getEvents(date: DateTime.parse(date));
  print('Events on ${DateTime.parse(date)}: ${events.length}');
  expect(events.length, greaterThan(0));
}
