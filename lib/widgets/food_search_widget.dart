import 'package:flutter/material.dart';
import '../services/usda_api_service.dart';
import '../services/food_intake_service.dart';

class FoodSearchWidget extends StatefulWidget {
  final VoidCallback? onFoodLogged;

  const FoodSearchWidget({Key? key, this.onFoodLogged}) : super(key: key);

  @override
  State<FoodSearchWidget> createState() => _FoodSearchWidgetState();
}

class _FoodSearchWidgetState extends State<FoodSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _searchFoods(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await USDAApiService.searchFoodsSimple(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error searching foods: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _getFoodDetailsAndLog(int fdcId) async {
    try {
      final foodDetails = await USDAApiService.getFoodDetails(fdcId);
      final nutrients = await USDAApiService.getFoodNutrients(fdcId);
      final description = foodDetails['description'] ?? 'Unknown Food';
      int calories = 0;
      for (final nutrient in nutrients) {
        if (nutrient['nutrientName'] == 'Energy' ||
            nutrient['nutrientName'] == 'Calories' ||
            nutrient['nutrientName'] == 'ENERC_KCAL') {
          calories = (nutrient['value'] ?? 0).round();
          break;
        }
      }
      if (calories <= 0) {
        calories = 1; // fallback to 1 calorie if not found
      }
      final quantity = await _showQuantityDialog(description, calories);
      if (quantity == null || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid quantity.')),
        );
        return;
      }
      try {
        await FoodIntakeService.logFood(
          name: description,
          calories: calories,
          quantity: quantity,
        );
        if (widget.onFoodLogged != null) widget.onFoodLogged!();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added $description ($calories x $quantity cal)')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not log food: $e')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding food: $e')),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for foods...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                            _errorMessage = null;
                          });
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // Debounce search
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (value == _searchController.text) {
                    _searchFoods(value);
                  }
                });
              },
            ),
          ),

          // Error Message
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          // Search Results
          _searchResults.isEmpty && !_isLoading
              ? const Center(
                  child: Text(
                    'Search for foods to see results',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Column(
                  children: List.generate(
                    _searchResults.length > 3 ? 3 : _searchResults.length,
                    (index) {
                      final food = _searchResults[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          title: Text(
                            food['description'] ?? 'Unknown Food',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (food['brandName'] != null)
                                Text('Brand: ${food['brandName']}'),
                              if (food['brandOwner'] != null)
                                Text('Brand Owner: ${food['brandOwner']}'),
                            ],
                          ),
                          trailing: const Icon(Icons.add),
                          onTap: () => _getFoodDetailsAndLog(food['fdcId']),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 