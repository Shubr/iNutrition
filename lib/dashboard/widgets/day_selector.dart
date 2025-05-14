import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DaySelector extends StatefulWidget {
  final List<DateTime> days;
  final ValueChanged<DateTime>? onDaySelected;
  final DateTime selectedDay;

  const DaySelector({
    super.key,
    required this.days,
    this.onDaySelected,
    required this.selectedDay,
  });

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  late DateTime _selectedDay;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedDay());
  }

  @override
  void didUpdateWidget(DaySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameDay(oldWidget.selectedDay, widget.selectedDay)) {
      _selectedDay = widget.selectedDay;
      _scrollToSelectedDay();
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
    widget.onDaySelected?.call(day);
    _scrollToSelectedDay();
  }

  void _scrollToSelectedDay() {
    if (!_scrollController.hasClients) return;

    final index = widget.days.indexWhere((d) => _isSameDay(d, _selectedDay));
    if (index != -1) {
      final screenWidth = MediaQuery.of(context).size.width;
      const itemWidth = 40.0;
      final centerPosition = (index * itemWidth) - (screenWidth / 4) + (itemWidth / 2);

      _scrollController.animateTo(
        centerPosition.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateDay(int direction) {
    final currentIndex = widget.days.indexWhere((d) => _isSameDay(d, _selectedDay));
    final newIndex = (currentIndex + direction).clamp(0, widget.days.length - 1);
    if (newIndex != currentIndex) {
      _selectDay(widget.days[newIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalItemsWidth = widget.days.length * 70.0;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: 90,
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _navigateDay(-1),
            ),
            if (totalItemsWidth < screenWidth)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.days.length,
                  (index) => _buildDayItem(widget.days[index]),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.days.length,
                  itemBuilder: (context, index) => _buildDayItem(widget.days[index]),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _navigateDay(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(DateTime day) {
    final isSelected = _isSameDay(day, _selectedDay);
    final dayName = DateFormat('E').format(day);
    final dayNumber = DateFormat('d').format(day);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GestureDetector(
        onTap: () => _selectDay(day),
        child: isSelected
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            dayNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dayNumber,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
