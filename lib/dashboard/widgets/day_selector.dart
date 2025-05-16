// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DaySelector extends StatefulWidget {
//   final List<DateTime> days;
//   final ValueChanged<DateTime>? onDaySelected;
//   final DateTime selectedDay;

//   const DaySelector({
//     super.key,
//     required this.days,
//     this.onDaySelected,
//     required this.selectedDay,
//   });

//   @override
//   State<DaySelector> createState() => DaySelectorState();
// }

// class DaySelectorState extends State<DaySelector> {
//   int _selectedIndex = 0;

//   final List<Map<String, String>> days = [
//     {"day": "Sat", "date": "15"},
//     {"day": "Sun", "date": "16"},
//     {"day": "Mon", "date": "17"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final totalItemsWidth = widget.days.length * 70.0;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Center(
//       child: SizedBox(
//         height: 90,
//         width: screenWidth,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.chevron_left),
//               onPressed: () => _navigateDay(-1),
//             ),
//             if (totalItemsWidth < screenWidth)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   widget.days.length,
//                   (index) => _buildDayItem(widget.days[index]),
//                 ),
//               )
//             else
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: widget.days.length,
//                   itemBuilder: (context, index) =>
//                       _buildDayItem(widget.days[index]),
//                 ),
//               ),
//             IconButton(
//               icon: const Icon(Icons.chevron_right),
//               onPressed: () => _navigateDay(1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDayItem(DateTime day) {
//     final isSelected = _isSameDay(day, _selectedDay);
//     final dayName = DateFormat('E').format(day);
//     final dayNumber = DateFormat('d').format(day);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       child: GestureDetector(
//         onTap: () => _selectDay(day),
//         child: isSelected
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.redAccent,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           dayName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Container(
//                           width: 32,
//                           height: 32,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.black,
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             dayNumber,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     dayName,
//                     style: const TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     dayNumber,
//                     style: const TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
