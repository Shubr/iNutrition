import 'package:flutter/material.dart';

class MealEntryScreen extends StatefulWidget {
  final String mealType;
  final String? userId; // Optional userId, passed from MealEntrySelector

  const MealEntryScreen({
    super.key,
    required this.mealType,
    this.userId,
  });

  @override
  State<MealEntryScreen> createState() => _MealEntryScreenState();
}

class _MealEntryScreenState extends State<MealEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _foodNameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  void _submitMeal() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isSubmitting = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF10A37F),
            content: Text(
              '${_foodNameController.text} added to ${widget.mealType} for ${widget.userId ?? "current user"}!',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );

        _foodNameController.clear();
        _caloriesController.clear();
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealTypeCapitalized =
        '${widget.mealType[0].toUpperCase()}${widget.mealType.substring(1)}';

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add $mealTypeCapitalized',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Enter details for your $mealTypeCapitalized meal",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (widget.userId != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Logging for user: ${widget.userId}",
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
              const SizedBox(height: 20),
              TextFormField(
                controller: _foodNameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(label: 'Food Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _caloriesController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  label: 'Calories',
                  hint: 'Enter calories (number)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter calories';
                  }
                  final calories = int.tryParse(value);
                  if (calories == null || calories <= 0) {
                    return 'Enter a valid positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10A37F),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isSubmitting ? null : _submitMeal,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF10A37F)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
