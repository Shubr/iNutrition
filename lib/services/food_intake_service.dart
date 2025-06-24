import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodLogEntry {
  final String id;
  final String name;
  final int calories;
  final int quantity;
  final DateTime timestamp;

  FoodLogEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.quantity,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'calories': calories,
        'quantity': quantity,
        'timestamp': timestamp.toIso8601String(),
      };

  factory FoodLogEntry.fromMap(Map<String, dynamic> map) {
    return FoodLogEntry(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      quantity: map['quantity'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class FoodIntakeService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String? get _userId => _auth.currentUser?.email;

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Get collection reference for today's food log entries using the new calorieIntake structure
  static CollectionReference<Map<String, dynamic>> _logCollection() {
    if (_userId == null) throw Exception('User not logged in');
    return _firestore
        .collection('calorieIntake')
        .doc(_userId)
        .collection(_todayKey());
  }

  /// Get collection reference for a specific date using the new calorieIntake structure
  static CollectionReference<Map<String, dynamic>> _logCollectionForDate(String dateKey) {
    if (_userId == null) throw Exception('User not logged in');
    return _firestore
        .collection('calorieIntake')
        .doc(_userId)
        .collection(dateKey);
  }

  /// Log a food entry for today. Throws if invalid input or not logged in.
  static Future<void> logFood({
    required String name,
    required int calories,
    required int quantity,
  }) async {
    if (name.isEmpty || calories <= 0 || quantity <= 0) {
      throw Exception('Invalid food log input');
    }
    final entry = FoodLogEntry(
      id: _firestore.collection('tmp').doc().id,
      name: name,
      calories: calories,
      quantity: quantity,
      timestamp: DateTime.now(),
    );
    await _logCollection().doc(entry.id).set(entry.toMap());
  }

  /// Get today's food log entries, most recent first.
  static Future<List<FoodLogEntry>> getTodayFoodLog() async {
    try {
      final snapshot = await _logCollection().orderBy('timestamp', descending: true).get();
      return snapshot.docs.map((doc) => FoodLogEntry.fromMap(doc.data())).toList();
    } catch (e) {
      return [];
    }
  }

  /// Real-time stream of today's food log entries.
  static Stream<List<FoodLogEntry>> todayFoodLogStream() {
    return _logCollection().orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => FoodLogEntry.fromMap(doc.data())).toList()
    );
  }

  /// Get today's total calories (sum of calories * quantity for all entries).
  static Future<int> getTodayTotalCalories() async {
    final entries = await getTodayFoodLog();
    int total = 0;
    for (final entry in entries) {
      total += entry.calories * entry.quantity;
    }
    return total;
  }

  /// Add a custom food (logs it and saves to customFoods for reuse).
  static Future<void> addCustomFood({
    required String name,
    required int calories,
    required int quantity,
  }) async {
    await logFood(name: name, calories: calories, quantity: quantity);
    if (_userId == null) return;
    await _firestore.collection('execStudent').doc(_userId).collection('customFoods').add({
      'name': name,
      'calories': calories,
      'quantity': quantity,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  /// Delete a food log entry by its ID.
  static Future<void> deleteFoodLogEntry(String entryId) async {
    try {
      await _logCollection().doc(entryId).delete();
    } catch (e) {
      // Optionally handle error
    }
  }

  /// Edit a food log entry (name, calories, quantity).
  static Future<void> editFoodLogEntry({
    required String entryId,
    required String name,
    required int calories,
    required int quantity,
  }) async {
    if (name.isEmpty || calories <= 0 || quantity <= 0) {
      throw Exception('Invalid food log input');
    }
    try {
      await _logCollection().doc(entryId).update({
        'name': name,
        'calories': calories,
        'quantity': quantity,
      });
    } catch (e) {
      // Optionally handle error
    }
  }

  /// Real-time stream of food log entries for a specific date.
  static Stream<List<FoodLogEntry>> foodLogStreamForDate(String dateKey) {
    return _logCollectionForDate(dateKey).orderBy('timestamp', descending: true).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => FoodLogEntry.fromMap(doc.data())).toList()
    );
  }

  /// Get food log entries for a specific date.
  static Future<List<FoodLogEntry>> getFoodLogForDate(String dateKey) async {
    try {
      final snapshot = await _logCollectionForDate(dateKey).orderBy('timestamp', descending: true).get();
      return snapshot.docs.map((doc) => FoodLogEntry.fromMap(doc.data())).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get all available dates for the current user
  static Future<List<String>> getAvailableDates() async {
    if (_userId == null) return [];
    try {
      final snapshot = await _firestore
          .collection('calorieIntake')
          .doc(_userId)
          .get();
      
      if (!snapshot.exists) return [];
      
      // Get all subcollections (dates)
      final collections = await snapshot.reference.listCollections();
      return collections.map((collection) => collection.id).toList()..sort((a, b) => b.compareTo(a));
    } catch (e) {
      return [];
    }
  }

  /// Get total calories for a specific date
  static Future<int> getTotalCaloriesForDate(String dateKey) async {
    final entries = await getFoodLogForDate(dateKey);
    int total = 0;
    for (final entry in entries) {
      total += entry.calories * entry.quantity;
    }
    return total;
  }

  /// Get calorie summary for multiple dates
  static Future<Map<String, int>> getCalorieSummary(List<String> dates) async {
    Map<String, int> summary = {};
    for (final date in dates) {
      summary[date] = await getTotalCaloriesForDate(date);
    }
    return summary;
  }

  /// Migrate existing data from old structure to new calorieIntake structure
  static Future<void> migrateExistingData() async {
    if (_userId == null) return;
    
    try {
      // Get existing data from old structure
      final oldCollection = _firestore
          .collection('execStudent')
          .doc(_userId)
          .collection('foodLog');
      
      final oldDocs = await oldCollection.get();
      
      for (final doc in oldDocs.docs) {
        final dateKey = doc.id;
        final entriesCollection = doc.reference.collection('entries');
        final entries = await entriesCollection.get();
        
        // Create new structure for this date
        final newCollection = _firestore
            .collection('calorieIntake')
            .doc(_userId)
            .collection(dateKey);
        
        // Migrate each entry
        for (final entryDoc in entries.docs) {
          final entryData = entryDoc.data();
          await newCollection.doc(entryDoc.id).set(entryData);
        }
        
        print('Migrated data for date: $dateKey');
      }
      
      print('Migration completed successfully');
    } catch (e) {
      print('Migration failed: $e');
    }
  }

  /// Check if user has data in the new structure
  static Future<bool> hasNewStructureData() async {
    if (_userId == null) return false;
    
    try {
      final doc = await _firestore
          .collection('calorieIntake')
          .doc(_userId)
          .get();
      
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
} 