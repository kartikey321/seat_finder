import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:seat_finder/widgets/seat_low.dart';
import 'package:seat_finder/widgets/seat_up.dart';

class SeatPair extends StatefulWidget {
  const SeatPair({
    super.key,
    required this.startIndex,
    required this.index,
  });

  final int startIndex;
  final int index;

  @override
  State<SeatPair> createState() => _SeatPairState();
}

class _SeatPairState extends State<SeatPair> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SeatLower(
          width: width,
          startIndex: widget.startIndex,
        ),
        SeatUpper(
          width: width,
          startIndex: widget.startIndex + 3,
        )
      ],
    );
  }
}
