Map<String, dynamic> localePhrases = {
  'location': {
      'en': 'Location',
      'ru': 'Локация',
      'update_position': {
        'en': 'Turn on GPS to update position',
        'ru': 'Включите GPS, чтобы обновить позицию',
      },
      'default_position': {
        'en': 'Default position',
        'ru': 'Позиция по-умолчанию',
      },
      'current_position': {
        'en': 'Current position',
        'ru': 'Текущая позиция',
      },
      'current_address': {
        'en': 'Current address',
        'ru': 'Текущий адрес',
      }

    },
  'data': {
    'press_detailed': {
      'en': 'Press on a box to detailed info.',
      'ru': 'Нажмите на контейнер для детальной информации.'
    },
    'do_not_exist_lable': {
      'en': 'not this time',
      'ru': 'не в это время'
    },
    'data_is_coming': {
      'en': 'Weather data is coming.. Press a button.',
      'ru': 'Данные приближаются.. Нажмите на кнопку.'
    },
    'hourly': {
      'en': 'Hourly',
      'ru': 'По часам',
    },
    'daily': {
      'en': 'Daily',
      'ru': 'По дням',
    },
    'press_one_more': {
      'daily': {
        'en': 'Press one more "Daily", please',
        'ru': 'Нажмите ещё раз "По дням"',
      },
      'hourly': {
        'en': 'Press one more "Hourly", please',
        'ru': 'Нажмите ещё раз "По часам"',
      },
    }
  },
  'time': {
    'date_format': {
      'en': 'EEEE, MMMM d',
      'ru': 'dd-MM-yyyy',
    },
    'day_time_format': {
      'en': 'h:mm a',
      'ru': 'k:mm',
    },
  },

};


Map<String, dynamic> dayFieldsInfo = {
  'time': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Weather on',
    'ru': 'Погода на',
  },
  'sunrise': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Sunrise',
    'ru': 'Восход',
  },
  'sunset': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Sunset',
    'ru': 'Закат',
  },
  'weather_main': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Main Info',
    'ru': 'Основная информация',
  },
  'weather_desc': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Description',
    'ru': 'Описание',
  },
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'day_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Day Temperature',
    'ru': 'Температура днём',
  },
  'min_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Min Temp.',
    'ru': 'Минимальная температура',
  },
  'max_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Max Temp.',
    'ru': 'Максимальная температура',
  },
  'night_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Night Temperature',
    'ru': 'Температура ночью',
  },
  'eve_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Evening Temp.',
    'ru': 'Температура вечером',
  },
  'morn_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Morning Temp.',
    'ru': 'Температура утром',
  },
  'day_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Day Temp. feels like',
    'ru': 'Темп. днём ощущается как',
  },
  'night_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Night Temp. feels like',
    'ru': 'Темп. ночью ощущается как',
  },
  'eve_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Evening Temp. feels like',
    'ru': 'Темп. вечером ощущается как',
  },
  'morn_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Morning Temp. feels like',
    'ru': 'Темп. утром ощущается как',
  },
  'pressure': {
    'unit': {
      'en': 'hPa',
      'ru': 'кПа',
    },
    'en': 'Pressure',
    'ru': 'Давление',
  },
  'humidity': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Humidity',
    'ru': 'Влажность',
  },
  'atmospheric_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Atmospheric Temp.',
    'ru': 'Температура в атмосфере',
  },
  'clouds': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Cloudiness',
    'ru': 'Облачность',
  },
  'wind_speed': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Speed',
    'ru': 'Скорость ветра',
  },
  'wind_degrees': {
    'unit': {
      'en': '°',
      'ru': '°',
    },
    'en': 'Wind Degrees',
    'ru': 'Ветер под углом',
  },
  'snow': {
    'unit': {
      'en': 'mm',
      'ru': 'мм',
    },
    'en': 'Snow',
    'ru': 'Снег',
  },
  'rain': {
    'unit': {
      'en': 'mm',
      'ru': 'мм',
    },
    'en': 'Rain',
    'ru': 'Дождь',
  },
};


Map<String, dynamic> hourFieldsInfo = {
  'time': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Weather on',
    'ru': 'Погода на',
  },
  'weather_main': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Main Info',
    'ru': 'Основная информация',
  },
  'weather_desc': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Description',
    'ru': 'Описание',
  },
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'temperature': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Temperature',
    'ru': 'Температура',
  },
  'temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Temperature feels like',
    'ru': 'Температура ощущается как',
  },
  'pressure': {
    'unit': {
      'en': 'hPa',
      'ru': 'кПа',
    },
    'en': 'Pressure',
    'ru': 'Давление',
  },
  'humidity': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Humidity',
    'ru': 'Влажность',
  },
  'atmospheric_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Atmospheric Temp.',
    'ru': 'Температура в атмосфере',
  },
  'clouds': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Cloudiness',
    'ru': 'Облачность',
  },
  'wind_speed': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Speed',
    'ru': 'Скорость ветра',
  },
  'wind_degrees': {
    'unit': {
      'en': '°',
      'ru': '°',
    },
    'en': 'Wind Degrees',
    'ru': 'Ветер под углом',
  },
  'snow': {
    'unit': {
      'en': 'mm',
      'ru': 'мм',
    },
    'en': 'Snow',
    'ru': 'Снег',
  },
  'rain': {
    'unit': {
      'en': 'mm',
      'ru': 'мм',
    },
    'en': 'Rain',
    'ru': 'Дождь',
  },
};


List<String> flatDayFields = [
  'time',
  'sunrise',
  'sunset',
  'weather_main',
  'weather_desc',
  // 'weather_icon_code',
  'day_temp',
  'min_temp',
  'max_temp',
  'night_temp',
  'eve_temp',
  'morn_temp',
  'day_temp_feels_like',
  'night_temp_feels_like',
  'eve_temp_feels_like',
  'morn_temp_feels_like',
  'pressure',
  'humidity',
  'atmospheric_temp',
  'clouds',
  'wind_speed',
  'wind_degrees',
  'snow',
  'rain',
];

List<String> flatHourFields = [
  'time',
  'weather_main',
  'weather_desc',
  // 'weather_icon_code',
  'temperature',
  'temp_feels_like',
  'pressure',
  'humidity',
  'atmospheric_temp',
  'clouds',
  'wind_speed',
  'wind_degrees',
  'snow',
  'rain',
];


enum dayFields {
  time,
  sunrise,
  sunset,
  weatherMain,
  weatherDesc,
  weatherIconCode,
  dayTemp,
  minTemp,
  maxTemp,
  nightTemp,
  eveTemp,
  mornTemp,
  dayTempFeelsLike,
  nightTempFeelsLike,
  eveTempFeelsLike,
  mornTempFeelsLike,
  pressure,
  humidity,
  atmosphericTemp,
  clouds,
  windSpeed,
  windDegrees,
  snow,
  rain,
}

enum hourFields {
  time,
  weatherMain,
  weatherDesc,
  weatherIconCode,
  temperature,
  tempFeelsLike,
  pressure,
  humidity,
  atmosphericTemp,
  clouds,
  windSpeed,
  windDegrees,
  snow,
  rain,
}