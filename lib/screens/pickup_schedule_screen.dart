import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class PickupScheduleScreen extends StatefulWidget {
  const PickupScheduleScreen({super.key});

  @override
  State<PickupScheduleScreen> createState() => _PickupScheduleScreenState();
}

class _PickupScheduleScreenState extends State<PickupScheduleScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<PickupEvent>> _events = {};
  
  // Sample pickup schedule data
  final List<PickupEvent> _pickupEvents = [
    PickupEvent(
      title: 'Organic Waste',
      date: DateTime.now().add(const Duration(days: 1)),
      type: WasteType.organic,
    ),
    PickupEvent(
      title: 'Recyclable Waste',
      date: DateTime.now().add(const Duration(days: 3)),
      type: WasteType.recyclable,
    ),
    PickupEvent(
      title: 'Hazardous Waste',
      date: DateTime.now().add(const Duration(days: 7)),
      type: WasteType.hazardous,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  void _loadEvents() {
    for (var event in _pickupEvents) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(event);
    }
  }

  List<PickupEvent> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Pickup Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: _scheduleNotification,
            tooltip: 'Set Reminder',
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Scheduled Pickups',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPickup,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay!);
    
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No pickups scheduled for ${DateFormat('MMM d, y').format(_selectedDay!)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            leading: _buildWasteTypeIcon(event.type),
            title: Text(event.title),
            subtitle: Text(
              DateFormat('h:mm a, EEE, MMM d, y').format(event.date),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.blue),
              onPressed: () => _scheduleNotification(event: event),
            ),
            onTap: () => _viewEventDetails(event),
          ),
        );
      },
    );
  }

  Widget _buildWasteTypeIcon(WasteType type) {
    IconData icon;
    Color color;
    
    switch (type) {
      case WasteType.organic:
        icon = Icons.eco;
        color = Colors.green;
        break;
      case WasteType.recyclable:
        icon = Icons.recycling;
        color = Colors.blue;
        break;
      case WasteType.hazardous:
        icon = Icons.warning;
        color = Colors.orange;
        break;
    }
    
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    );
  }

  void _addNewPickup() {
    // TODO: Implement add new pickup functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add new pickup functionality coming soon!')),
    );
  }

  void _viewEventDetails(PickupEvent event) {
    // TODO: Implement view event details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${DateFormat('EEEE, MMMM d, y').format(event.date)}'),
            Text('Time: ${DateFormat('h:mm a').format(event.date)}'),
            const SizedBox(height: 16),
            Text('Type: ${event.type.toString().split('.').last}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement edit functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit functionality coming soon!')),
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _scheduleNotification({PickupEvent? event}) {
    // TODO: Implement notification scheduling
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          event != null 
              ? 'Reminder set for ${event.title} pickup!'
              : 'Reminder functionality coming soon!',
        ),
      ),
    );
  }
}

class PickupEvent {
  final String title;
  final DateTime date;
  final WasteType type;

  PickupEvent({
    required this.title,
    required this.date,
    required this.type,
  });
}

enum WasteType {
  organic,
  recyclable,
  hazardous,
}
