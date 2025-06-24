import 'package:flutter/material.dart';
import 'package:inutrition/execStudentPage/progressBar.dart';
import 'package:inutrition/widgets/iWidget.dart';
import 'package:inutrition/widgets/food_search_widget.dart';
import 'package:inutrition/services/food_intake_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExecStudentDashboard extends StatefulWidget {
  const ExecStudentDashboard({super.key});

  @override
  State<ExecStudentDashboard> createState() => _ExecStudentDashboardState();
}

class _ExecStudentDashboardState extends State<ExecStudentDashboard> {
  int _dailyGoal = 2000; // Default value
  String? _userName;
  bool _loadingName = true;
  bool _loadingGoal = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadDailyGoal();
    _checkAndMigrateData();
  }

  Future<void> _loadDailyGoal() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('execStudent')
            .doc(user.email)
            .get();
        if (doc.exists && doc.data() != null) {
          setState(() {
            _dailyGoal = doc.data()!['dailyGoal'] ?? 2000;
            _loadingGoal = false;
          });
        } else {
          setState(() {
            _loadingGoal = false;
          });
        }
      } else {
        setState(() {
          _loadingGoal = false;
        });
      }
    } catch (e) {
      setState(() {
        _loadingGoal = false;
      });
    }
  }

  Future<void> _loadUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('execStudent')
            .doc(user.email)
            .get();
        if (doc.exists && doc.data() != null && doc.data()!['name'] != null) {
          setState(() {
            _userName = doc.data()!['name'];
            _loadingName = false;
          });
        } else {
          setState(() {
            _userName = user.email;
            _loadingName = false;
          });
        }
      } else {
        setState(() {
          _userName = 'User';
          _loadingName = false;
        });
      }
    } catch (e) {
      setState(() {
        _userName = 'User';
        _loadingName = false;
      });
    }
  }

  Future<void> _checkAndMigrateData() async {
    try {
      final hasNewData = await FoodIntakeService.hasNewStructureData();
      if (!hasNewData) {
        // Check if user has old data to migrate
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final oldDataExists = await FirebaseFirestore.instance
              .collection('execStudent')
              .doc(user.email)
              .collection('foodLog')
              .get();
          
          if (oldDataExists.docs.isNotEmpty) {
            // Show migration dialog
            if (mounted) {
              _showMigrationDialog();
            }
          }
        }
      }
    } catch (e) {
      // Silently handle migration check errors
    }
  }

  void _showMigrationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Migrate Data'),
        content: const Text(
          'We found existing calorie data in the old format. Would you like to migrate it to the new structure? This will preserve all your food entries.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _performMigration();
            },
            child: const Text('Migrate'),
          ),
        ],
      ),
    );
  }

  Future<void> _performMigration() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Migrating data...'),
            ],
          ),
        ),
      );

      await FoodIntakeService.migrateExistingData();
      
      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data migration completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Migration failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onFoodSelected(Map<String, dynamic> foodInfo) async {
    try {
      final details = foodInfo['details'];
      final nutrients = foodInfo['nutrients'];
      
      // Find calories in nutrients
      int calories = 0;
      for (final nutrient in nutrients) {
        if (nutrient['nutrientName'] == 'Energy' || 
            nutrient['nutrientName'] == 'Calories' ||
            nutrient['nutrientName'] == 'ENERC_KCAL') {
          calories = (nutrient['value'] ?? 0).round();
          break;
        }
      }
      
      // Show quantity dialog
      final quantity = await _showQuantityDialog(details['description'] ?? 'Food', calories);
      if (quantity != null && quantity > 0) {
        await FoodIntakeService.logFood(
          name: details['description'] ?? 'Food',
          calories: calories,
          quantity: quantity,
        );
        
        // StreamBuilder will automatically update the UI
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${details['description']} (${calories * quantity} calories)'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding food: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<int?> _showQuantityDialog(String foodName, int calories) async {
    final quantityController = TextEditingController(text: '1');
    return showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $foodName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Calories per serving: $calories'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity (servings)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text.trim()) ?? 0;
              Navigator.pop(context, quantity);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddCustomFoodDialog() {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Food'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: caloriesController,
              decoration: const InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
              final quantity = int.tryParse(quantityController.text.trim()) ?? 1;
              if (name.isNotEmpty && calories > 0 && quantity > 0) {
                await FoodIntakeService.addCustomFood(
                  name: name,
                  calories: calories,
                  quantity: quantity,
                );
                Navigator.pop(context);
                // StreamBuilder will automatically update the UI
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Custom food added!')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: _loadingName
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(_userName ?? 'User'),
        titleTextStyle: const TextStyle(
            fontFamily: "Alex",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Center(
              child: _loadingGoal
                  ? const SizedBox(
                      width: 210,
                      height: 210,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : StreamBuilder<List<FoodLogEntry>>(
                      stream: FoodIntakeService.todayFoodLogStream(),
                      builder: (context, snapshot) {
                        int currentCalories = 0;
                        if (snapshot.hasData) {
                          for (final entry in snapshot.data!) {
                            currentCalories += entry.calories * entry.quantity;
                          }
                        }
                        return Progressbar(
                          currentCalories: currentCalories,
                          dailyGoal: _dailyGoal,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FoodSearchWidget(onFoodLogged: () {
                    // The StreamBuilder will automatically update when food is logged
                  }),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _showAddCustomFoodDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Custom Food'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StreamBuilder<List<FoodLogEntry>>(
                stream: FoodIntakeService.todayFoodLogStream(),
                builder: (context, snapshot) {
                  int currentCalories = 0;
                  if (snapshot.hasData) {
                    for (final entry in snapshot.data!) {
                      currentCalories += entry.calories * entry.quantity;
                    }
                  }
                  return Text(
                    'Today\'s Calories: $currentCalories / $_dailyGoal',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            const SizedBox(height: 24), // Add bottom padding
          ],
        ),
      ),
    );
  }
}
