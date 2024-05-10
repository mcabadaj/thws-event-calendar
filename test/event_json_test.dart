import 'package:test/test.dart';
import 'package:thws_event_calendar/data/models/event.dart';

main() async {
  final Map<String, dynamic> eventJson = {
    'endTime': '2024-05-10T09:45:00+02:00',
    'id': 178,
    'lecturersToShow': 'Patrik Stilgenbauer',
    'name': 'Statistik',
    'roomsToShow': 'SHL',
    'startTime': '2024-05-10T08:15:00+02:00',
    'studyGroupsToShow': 'BEC2',
    'type': 'Lecture'
  };
  final event = Event.fromJson(eventJson);

  test('All values equal', () => _valuesEqual(event));
}

void _valuesEqual(event) {
  assert(event.id == 178);
  assert(event.name == 'Statistik');
  assert(event.type == 'Lecture');
  assert(event.semesters[0] == 'BEC2');
  assert(event.lecturers[0] == 'Patrik Stilgenbauer');
  assert(event.rooms[0] == 'SHL');
  assert(event.start.toString() == '2024-05-10 08:15:00.000');
  assert(event.end.toString() == '2024-05-10 09:45:00.000');
}
