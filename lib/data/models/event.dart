import '../../util/json/json_tools.dart' as jsont;

class Event {
  final int id;
  final String name;
  final String type;
  final List<String> semesters;
  final List<String> lecturers;
  final List<String> rooms;
  final DateTime start;
  final DateTime end;

  const Event({
    required this.id,
    required this.name,
    required this.type,
    required this.semesters,
    required this.lecturers,
    required this.rooms,
    required this.start,
    required this.end,
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        semesters = jsont.fromListString(json['studyGroupsToShow']),
        lecturers = jsont.fromListString(json['lecturersToShow']),
        rooms = jsont.fromListString(json['roomsToShow']),
        start = DateTime.parse(json['startTime']).toLocal(),
        end = DateTime.parse(json['endTime']).toLocal();
}
