extension WeekDayConversion on DateTime{
  String getWeekDateName(){
    const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
    return weekdayName[weekday]!;
  }
  String getMonthName(){
    const Map<int, String> weekdayName = {1: "Jan", 2: "Feb", 3: "March", 4: "April", 5: "May", 6: "June", 7: "July",8: "Aug",9: "Sept",10: "Oct",11: "Nov",12: "Dec"};
    return weekdayName[month]!;
  }
}