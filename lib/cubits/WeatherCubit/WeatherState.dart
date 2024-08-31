
class WeatherState{}

class WeatherInitialState extends WeatherState{}
class WeatherISLoadingState extends WeatherState{}

class WeatherLoadedState extends WeatherState{}
class WeatherFiledState extends WeatherState{
  final String error;

  WeatherFiledState({required this.error});

}