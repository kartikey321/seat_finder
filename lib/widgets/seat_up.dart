import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/screens/seat_finder.dart';

import '../app_data.dart';
import '../helpers.dart';

class SeatUpper extends StatefulWidget {
  const SeatUpper({
    super.key,
    required this.width,
    required this.startIndex,
  });

  final double width;
  final int startIndex;

  @override
  State<SeatUpper> createState() => _SeatUpperState();
}

class _SeatUpperState extends State<SeatUpper> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AppData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 75,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 45,
                  width: 0.53 * widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 15,
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
                            padding: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (widget.startIndex + index ==
                                      prov.searchedSeat)
                                  ? Colors.blue
                                  : Colors.blue[100],
                            ),
                            width: 65,
                            height: 60,
                            child: Column(
                              children: [
                                Text(
                                  Helpers.getSeatType(
                                      widget.startIndex + index),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (widget.startIndex + index ==
                                            prov.searchedSeat)
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                ),
                                Text(
                                  '${widget.startIndex + index}',
                                  style: TextStyle(
                                      color: (widget.startIndex + index ==
                                              prov.searchedSeat)
                                          ? Colors.white
                                          : Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
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
          height: 75,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                child: Container(
                  height: 45,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    if (searchState == SearchState.NOT_SEARCHING) {
                      if ((widget.startIndex + 4) == prov.searchedSeat) {
                        Provider.of<AppData>(context, listen: false)
                            .setSearchedSeat(0);
                      } else {
                        Provider.of<AppData>(context, listen: false)
                            .setSearchedSeat(widget.startIndex + 4);
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ((widget.startIndex + 4) == prov.searchedSeat)
                          ? Colors.blue
                          : Colors.blue[100],
                    ),
                    height: 60,
                    child: Column(
                      children: [
                        Text(
                          Helpers.getSeatType(widget.startIndex + 4),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            color: (widget.startIndex + 4) == prov.searchedSeat
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                        Text(
                          '${widget.startIndex + 4}',
                          style: TextStyle(
                              color:
                                  (widget.startIndex + 4) == prov.searchedSeat
                                      ? Colors.white
                                      : Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
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
