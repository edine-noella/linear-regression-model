import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://methane-emissions-from-landfill.onrender.com/"; // Replace with your Render URL

  static Future<Map<String, dynamic>> predictEmission({
    required double organicWaste,
    required int population,
    required double gdpPerCapita,
    required double landfill,
    required double wastePerCapita,
  }) async {
    final url = Uri.parse(
        'https://methane-emissions-from-landfill.onrender.com/predict');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'organic_waste': organicWaste,
          'population': population,
          'gdp_per_capita': gdpPerCapita,
          'landfill': landfill,
          'waste_per_capita': wastePerCapita,
        }),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        // Handle the actual API response format
        if (responseBody.containsKey('predicted_emission')) {
          return {
            'prediction': responseBody['predicted_emission'],
            'units': 'metric tons CO2 equivalent'
            // Adding units since your API doesn't return it
          };
        } else {
          throw Exception('API response missing predicted_emission field');
        }
      } else {
        throw Exception('API Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to get prediction: $e');
    }
  }
}