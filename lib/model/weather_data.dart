import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/weather_data.freezed.dart';
part 'generated/weather_data.g.dart';

@freezed
abstract class WeatherData with _$WeatherData {
  @JsonSerializable(fieldRename: FieldRename.snake, checked: true)
  const factory WeatherData({
    required String weatherCondition,
    required int maxTemperature,
    required int minTemperature,
    required String date,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) => 
    _$WeatherDataFromJson(json);
}
