import '../models/event.dart';

class EventRepository {
  EventRepository._();

  static final List<Event> events = [
    Event(
      id: 'event-1',
      title: 'City Run Festival',
      location: 'Central Park',
      description: 'A lively run with music, food trucks, and prizes for all ages.',
      date: DateTime.now().add(const Duration(days: 5, hours: 16)),
      capacity: 180,
    ),
    Event(
      id: 'event-2',
      title: 'Startup Networking Night',
      location: 'Lumen Hall',
      description: 'Meet local founders, enjoy energetic talks, and build valuable connections.',
      date: DateTime.now().add(const Duration(days: 11, hours: 18)),
      capacity: 120,
    ),
    Event(
      id: 'event-3',
      title: 'Art & Innovation Expo',
      location: 'Riverfront Center',
      description: 'Explore creative installations and inspiring demonstrations from local artists.',
      date: DateTime.now().add(const Duration(days: 20, hours: 10)),
      capacity: 250,
    ),
  ];

  static void add(Event event) {
    events.insert(0, event);
  }

  static void update(Event updatedEvent) {
    final index = events.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      events[index] = updatedEvent;
    }
  }

  static void remove(String id) {
    events.removeWhere((event) => event.id == id);
  }

  static Event? findById(String id) {
    try {
      return events.firstWhere((event) => event.id == id);
    } catch (_) {
      return null;
    }
  }
}
