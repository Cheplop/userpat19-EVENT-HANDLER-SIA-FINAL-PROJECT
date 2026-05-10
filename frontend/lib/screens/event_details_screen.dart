import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _DetailChip(label: 'Date', value: _formatDate(event.date)),
                _DetailChip(label: 'Location', value: event.location),
                _DetailChip(label: 'Capacity', value: '${event.capacity} people'),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'About this event',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              event.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to events'),
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year} • ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _DetailChip extends StatelessWidget {
  final String label;
  final String value;

  const _DetailChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      label: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
