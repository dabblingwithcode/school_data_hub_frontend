import 'package:flutter/material.dart';

//- A timetable example

class Lesson {
  final String teacher;
  final String subject;
  final String group;
  final String room;
  final String weekday;
  final int time;

  Lesson(this.teacher, this.subject, this.group, this.room, this.weekday,
      this.time);
}

class Timetable extends StatelessWidget {
  final List<Lesson> lessons = [
    Lesson('Mr. Smith', 'Math', 'Group 1', 'Room 101', 'Monday', 1),
    Lesson('Ms. Johnson', 'English', 'Group 2', 'Room 102', 'Tuesday', 2),
    Lesson('Mr. Williams', 'Science', 'Group 3', 'Room 103', 'Wednesday', 3),
    Lesson('Mrs. Brown', 'History', 'Group 4', 'Room 104', 'Thursday', 4),
    Lesson('Ms. Jones', 'Art', 'Group 5', 'Room 105', 'Friday', 5),
  ]..sort((a, b) => a.time.compareTo(b.time));

  Timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${lessons[index].weekday} ${lessons[index].time}:00'),
                  ),
                ),
              ),
              ...lessons.map((lesson) {
                return Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Teacher: ${lesson.teacher}'),
                          Text('Subject: ${lesson.subject}'),
                          Text('Group: ${lesson.group}'),
                          Text('Room: ${lesson.room}'),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
