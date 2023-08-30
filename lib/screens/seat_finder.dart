import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/app_data.dart';
import 'package:seat_finder/helpers.dart';
import 'package:seat_finder/widgets/seat_pair.dart';

enum SearchState { SEARCHING, NOT_SEARCHING }

SearchState searchState = SearchState.NOT_SEARCHING;

class SeatFinder extends StatefulWidget {
  const SeatFinder({Key? key}) : super(key: key);

  @override
  State<SeatFinder> createState() => _SeatFinderState();
}

class _SeatFinderState extends State<SeatFinder> {
  late ScrollController scrollController;
  bool isScrollButtonVisible = false;
  final int NO_OF_SEATS = 80;
  final searchController = TextEditingController();

  bool isItemVisible(int index) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = (screenHeight - kToolbarHeight - 100) / 3.5;
    final itemTop = index * itemHeight;
    final itemBottom = (index + 1) * itemHeight;

    final viewportTop = scrollController.position.pixels;
    final viewportBottom = scrollController.position.pixels + screenHeight;

    // Check if the item is within the viewport.
    return (itemTop < viewportBottom && itemBottom > viewportTop);
  }

  addScrollListner() {
    scrollController.addListener(() {
      int coachNo = Helpers.getCoachNo(int.parse(searchController.text));
      var isVisible = isItemVisible(coachNo - 1);
      if (!isVisible) {
        setState(() {
          isScrollButtonVisible = true;
        });
        // scrollToCoach(coachNo);
      } else {
        setState(() {
          isScrollButtonVisible = false;
        });
      }
    });
  }

  dispoeScrollListner() {
    setState(() {
      isScrollButtonVisible = false;
    });
    // scrollController.dispose();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  scrollToCoach(int coachNo) {
    if (coachNo < 3) {
      scrollController.animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else {
      scrollController.animateTo((120 * (coachNo)).toDouble(),
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isScrollButtonVisible
          ? InkWell(
              onTap: () {
                int coachNo =
                    Helpers.getCoachNo(int.parse(searchController.text));

                scrollToCoach(coachNo);
              },
              child: Container(
                width: 200,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                child: Center(
                    child: Text(
                  'Scroll to Searched Seat',
                  style: TextStyle(color: Colors.white),
                )),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          : const SizedBox(),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'SeatFinder',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      scrollPadding: EdgeInsets.only(top: 0),
                      onChanged: (wd) {
                        setState(() {});
                      },
                      controller: searchController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Seat Number',
                        hintStyle: TextStyle(color: Colors.blue[200]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (searchController.text.length > 0) {
                        if (searchState == SearchState.NOT_SEARCHING) {
                          setState(() {
                            searchState = SearchState.SEARCHING;
                          });
                          Provider.of<AppData>(context, listen: false)
                              .setSearchedSeat(
                                  int.parse(searchController.text));

                          FocusManager.instance.primaryFocus?.unfocus();
                          int coachNo = Helpers.getCoachNo(
                              int.parse(searchController.text));
                          scrollToCoach(coachNo);
                          addScrollListner();
                        } else {
                          setState(() {
                            searchState = SearchState.NOT_SEARCHING;
                            Provider.of<AppData>(context, listen: false)
                                .setSearchedSeat(0);
                          });
                          searchController.clear();
                          dispoeScrollListner();
                        }
                      }
                    },
                    child: Container(
                      height: 65,
                      width: 100,
                      decoration: BoxDecoration(
                        color: searchController.text.length > 0
                            ? Colors.blue
                            : Colors.blue[300],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          searchState == SearchState.SEARCHING
                              ? 'Clear'
                              : 'Find',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SeatPair(
                      index: index,
                      startIndex: index * 8 + 1,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 3,
                    );
                  },
                  itemCount: (NO_OF_SEATS / 8).ceil()),
            ),
          ],
        ),
      ),
    );
  }
}
