import 'package:weather_app_2_0/data/api/model/day/api_day.dart';


class ApiDaily {
  static List<ApiDay> fromApi(Map<String, dynamic> dailyMap) {
    final dayNum = dailyMap["daily"].length;
    List<ApiDay> apiDayList = [];

    for (int i = 0; i < dayNum; i++) {
      apiDayList.add(ApiDay.fromApi(dailyMap, i));
    }
    return apiDayList;
  }
}
