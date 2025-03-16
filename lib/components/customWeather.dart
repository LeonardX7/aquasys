import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomWeather extends StatefulWidget {
  const CustomWeather({super.key});

  @override
  _CustomWeatherState createState() => _CustomWeatherState();
}

class _CustomWeatherState extends State<CustomWeather> {
  String city = "Getting location...";
  double temperature = 0;
  int humidity = 0;
  int windSpeed = 0;
  int rainChance = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Location services are disabled. Please enable them.')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied')));
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        setState(() {
          city = "Location permission denied";
          isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        city = "Error getting location";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    await dotenv.load(fileName: ".env");
    var apiKey = dotenv.env['API_KEY'];
    const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
    final url = '$baseURL?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          city = data["name"];
          temperature = data["main"]["temp"];
          humidity = data["main"]["humidity"];
          windSpeed = (data["wind"]["speed"] as num).toInt();
          rainChance = data["clouds"]["all"];
        });
      }
    } catch (e) {
      setState(() {
        city = "Error fetching weather data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              CircularProgressIndicator(color: theme.colorScheme.primary)
            else ...[
              GestureDetector(
                onTap: _getCurrentLocation,
                child: Text(
                  city,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${temperature.toInt()}°C",
                style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 64,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wind: ${windSpeed} km/h",
                    style: TextStyle(
                        color: theme.colorScheme.primary, fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Humidity: ${humidity}%",
                    style: TextStyle(
                        color: theme.colorScheme.primary, fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Rain: ${rainChance}%",
                    style: TextStyle(
                        color: theme.colorScheme.primary, fontSize: 16),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
