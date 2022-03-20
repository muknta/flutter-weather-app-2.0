import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';

class ApiHourly {
  static List<ApiHour> fromApi(Map<String, dynamic> hourlyMap) {
    final hourNum = hourlyMap["hourly"].length;
    final List<ApiHour> apiHourList = [];

    for (int i = 0; i < hourNum; i++) {
      print('hourlyMap $hourlyMap');
      apiHourList.add(ApiHour.fromApi(hourlyMap, i));
    }
    return apiHourList;
  }
}
