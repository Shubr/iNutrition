import 'package:flutter/material.dart';
import 'services/food_intake_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int _userRDI = 2000; // Default value
  bool _isLoadingRDI = true;

  @override
  void initState() {
    super.initState();
    _loadUserRDI();
  }

  Future<void> _loadUserRDI() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('execStudent')
            .doc(user.email)
            .get();
        
        if (doc.exists) {
          final data = doc.data()!;
          setState(() {
            _userRDI = data['dailyGoal'] ?? 2000;
            _isLoadingRDI = false;
          });
        } else {
          setState(() {
            _isLoadingRDI = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        _isLoadingRDI = false;
      });
    }
  }

  int _calculateTotal(List<FoodLogEntry> log) {
    int total = 0;
    for (final entry in log) {
      total += entry.calories * entry.quantity;
    }
    return total;
  }

  String _rdiStatus(int total) {
    if (total < _userRDI) return 'Below RDI';
    if (total == _userRDI) return 'Met RDI';
    return 'Above RDI';
  }

  Color _rdiColor(int total) {
    if (total < _userRDI) return Colors.orange;
    if (total == _userRDI) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Today\'s Food Log'),
        titleTextStyle: const TextStyle(
          fontFamily: "Alex",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage(userRDI: _userRDI)),
              );
            },
          ),
        ],
      ),
      body: _isLoadingRDI
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<FoodLogEntry>>(
              stream: FoodIntakeService.todayFoodLogStream(),
              builder: (context, snapshot) {
                final foodLog = snapshot.data ?? [];
                final totalCalories = _calculateTotal(foodLog);
                final rdiStatus = _rdiStatus(totalCalories);
                final rdiColor = _rdiColor(totalCalories);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Calories: $totalCalories',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'RDI: $_userRDI',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                rdiStatus,
                                style: TextStyle(
                                  color: rdiColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                rdiStatus == 'Met RDI'
                                    ? Icons.check_circle
                                    : rdiStatus == 'Below RDI'
                                        ? Icons.arrow_downward
                                        : Icons.warning,
                                color: rdiColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: foodLog.isEmpty
                          ? const Center(
                              child: Text(
                                'No foods logged today.',
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : ListView.builder(
                              itemCount: foodLog.length,
                              itemBuilder: (context, i) {
                                final entry = foodLog[i];
                                return Card(
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: ListTile(
                                    title: Text(entry.name),
                                    subtitle: Text(
                                        'Quantity: ${entry.quantity}  |  Calories: ${entry.calories * entry.quantity}'),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                        await FoodIntakeService.deleteFoodLogEntry(entry.id);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class HistoryPage extends StatefulWidget {
  final int userRDI;
  
  const HistoryPage({super.key, required this.userRDI});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<DateTime> _selectedDates = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRecentDates();
  }

  void _loadRecentDates() {
    setState(() {
      _isLoading = true;
    });
    
    // Generate last 7 days
    final now = DateTime.now();
    _selectedDates = List.generate(7, (index) {
      return DateTime(now.year, now.month, now.day - index);
    });
    
    setState(() {
      _isLoading = false;
    });
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return 'Today';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  String _rdiStatus(int total) {
    if (total < widget.userRDI) return 'Below RDI';
    if (total == widget.userRDI) return 'Met RDI';
    return 'Above RDI';
  }

  Color _rdiColor(int total) {
    if (total < widget.userRDI) return Colors.orange;
    if (total == widget.userRDI) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary History'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRecentDates,
            tooltip: 'Refresh',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _selectedDates.length,
              itemBuilder: (context, index) {
                final date = _selectedDates[index];
                final dateString = DateFormat('yyyy-MM-dd').format(date);
                
                return StreamBuilder<List<FoodLogEntry>>(
                  stream: FoodIntakeService.foodLogStreamForDate(dateString),
                  builder: (context, snapshot) {
                    final foodLog = snapshot.data ?? [];
                    final totalCalories = foodLog.fold<int>(
                      0, (sum, entry) => sum + (entry.calories * entry.quantity));
                    final rdiStatus = _rdiStatus(totalCalories);
                    final rdiColor = _rdiColor(totalCalories);
                    
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatDate(date),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: rdiColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$totalCalories cal',
                                style: TextStyle(
                                  color: rdiColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'RDI: ${widget.userRDI} | $rdiStatus',
                          style: TextStyle(color: rdiColor),
                        ),
                        children: [
                          if (foodLog.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No foods logged on this day.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          else
                            ...foodLog.map((entry) => ListTile(
                              dense: true,
                              title: Text(entry.name),
                              subtitle: Text('Quantity: ${entry.quantity}'),
                              trailing: Text(
                                '${entry.calories * entry.quantity} cal',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
} 