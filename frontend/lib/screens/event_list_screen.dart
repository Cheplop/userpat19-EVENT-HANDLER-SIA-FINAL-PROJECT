import 'package:flutter/material.dart';
import '../data/event_repository.dart';
import '../models/event.dart';
import 'event_details_screen.dart';
import 'event_form_screen.dart';
import 'login_screen.dart';

class EventListScreen extends StatefulWidget {
  final bool isAdmin;

  const EventListScreen({super.key, required this.isAdmin});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  void _openDetails(Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EventDetailsScreen(event: event)),
    );
  }

  void _openForm([Event? event]) async {
    final changed = await Navigator.of(context).push<bool?>(
      MaterialPageRoute(builder: (_) => EventFormScreen(event: event)),
    );
    if (changed == true) {
      setState(() {});
    }
  }

  void _confirmDelete(Event event) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete event?'),
          content: Text('Remove "${event.title}" from the event list?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete')),
          ],
        );
      },
    );
    if (shouldDelete == true) {
      EventRepository.remove(event.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = EventRepository.events;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAdmin ? 'Admin Events' : 'Available Events'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(widget.isAdmin ? 'Admin' : 'Guest', style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () => _openForm(),
              label: const Text('New Event'),
              icon: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Events to explore',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Browse upcoming activities and stay engaged with exciting experiences.',
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: events.isEmpty
                    ? Center(
                        child: Text(
                          'No events available yet.',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      )
                    : ListView.separated(
                        itemCount: events.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return _EventTile(
                            event: event,
                            isAdmin: widget.isAdmin,
                            onDelete: () => _confirmDelete(event),
                            onEdit: () => _openForm(event),
                            onView: () => _openDetails(event),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;
  final bool isAdmin;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EventTile({
    required this.event,
    required this.isAdmin,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onView,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black45),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _LabelChip(label: 'Date', value: '${event.date.month}/${event.date.day}/${event.date.year}'),
                  _LabelChip(label: 'Location', value: event.location),
                  _LabelChip(label: 'Capacity', value: '${event.capacity}'),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700], height: 1.4),
              ),
              if (isAdmin) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: 12),
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Delete'),
                      style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  final String label;
  final String value;

  const _LabelChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color(0xFFf4f7ff),
      label: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }
}
