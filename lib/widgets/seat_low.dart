import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/helpers.dart';
import 'package:seat_finder/screens/seat_finder.dart';

import '../app_data.dart';

class SeatLower extends StatefulWidget {
  const SeatLower({
    super.key,
    required this.width,
    required this.startIndex,
  });

  final double width;
  final int startIndex;

  @override
  State<SeatLower> createState() => _SeatLowerState();
}

class _SeatLowerState extends State<SeatLower> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AppData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          height: 100,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 45,
                  width: 0.53 * widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: Row(
                  children: List.generate(3, (index) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (searchState == SearchState.NOT_SEARCHING) {
                              if ((widget.startIndex + index) ==
                                  prov.searchedSeat) {
                                Provider.of<AppData>(context, listen: false)
                                    .setSearchedSeat(0);
                              } else {
                                Provider.of<AppData>(context, listen: false)
                                    .setSearchedSeat(widget.startIndex + index);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (widget.startIndex + index) ==
                                      prov.searchedSeat
                                  ? Colors.blue
                                  : Colors.blue[100],
                            ),
                            width: 65,
                            height: 60,
                            child: Column(
                              children: [
                                Text(
                                  '${widget.startIndex + index}',
                                  style: TextStyle(
                                      color: (widget.startIndex + index) ==
                                              prov.searchedSeat
                                          ? Colors.white
                                          : Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  Helpers.getSeatType(
                                      widget.startIndex + index),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (widget.startIndex + index) ==
                                            prov.searchedSeat
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (index < 2)
                          VerticalDivider(width: 3, color: Colors.white),
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 100,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 45,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    if (searchState == SearchState.NOT_SEARCHING) {
                      if ((widget.startIndex + 6) == prov.searchedSeat) {
                        Provider.of<AppData>(context, listen: false)
                            .setSearchedSeat(0);
                      } else {
                        Provider.of<AppData>(context, listen: false)
                            .setSearchedSeat(widget.startIndex + 6);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (widget.startIndex + 6 == prov.searchedSeat)
                          ? Colors.blue
                          : Colors.blue[100],
                    ),
                    height: 60,
                    child: Column(
                      children: [
                        Text(
                          '${widget.startIndex + 6}',
                          style: TextStyle(
                              color:
                                  (widget.startIndex + 6 == prov.searchedSeat)
                                      ? Colors.white
                                      : Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: Text(
                            Helpers.getSeatType(widget.startIndex + 6),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  (widget.startIndex + 6 == prov.searchedSeat)
                                      ? Colors.white
                                      : Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
