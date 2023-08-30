class Helpers {
  static String getSeatType(int seatNumber) {
    if (seatNumber % 8 == 1 || seatNumber % 8 == 4) {
      return 'Lower';
    } else if (seatNumber % 8 == 2 || seatNumber % 8 == 5) {
      return 'Middle';
    } else if (seatNumber % 8 == 3 || seatNumber % 8 == 6) {
      return 'Upper';
    } else if (seatNumber % 8 == 7) {
      return 'S.Lower';
    } else if (seatNumber % 8 == 0) {
      return 'S.Upper';
    } else {
      return 'Invalid Seat Number';
    }
  }

  static int getCoachNo(int index) => (index / 8).ceil();
}
