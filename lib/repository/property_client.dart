import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:property/model/properties_response.dart';

class PropertyClient {
  final http.Client httpClient;
  final String baseUrl = "https://donphelix.com/api/api/properties";

  PropertyClient({httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<Property>> getProperties() async {
    final response = await httpClient.get(
      Uri.parse(baseUrl),
    );
    final results = json.decode(response.body);

    print(results);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PropertiesResponse.fromJson(results)
              .data
              ?.map((property) => property)
              .toList() ??
          [];
    } else {
      throw Exception('Failed to get properties: ${response.body}');
    }
  }

  Future<Property> createProperty(Map<String, dynamic> propertyData) async {
    if (!isValidPropertyData(propertyData)) {
      throw Exception("Invalid property data provided");
    }

    final response = await httpClient.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(propertyData),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = json.decode(response.body);
      return Property.fromJson(result['data']);
    } else {
      throw Exception('Failed to create property: ${response.body}');
    }
  }

  Future<Property> updateProperty(
      num id, Map<String, dynamic> updatedData) async {
    if (!isValidPropertyData(updatedData)) {
      throw Exception("Invalid updated data provided");
    }

    final response = await httpClient.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = json.decode(response.body);
      return Property.fromJson(result['data']);
    } else {
      throw Exception('Failed to update property: ${response.body}');
    }
  }

  bool isValidPropertyData(Map<String, dynamic> data) {
    if (!data.containsKey('title') || data['title'].isEmpty) return false;
    if (!data.containsKey('description') || data['description'].isEmpty)
      return false;
    if (!data.containsKey('location') || data['location'].isEmpty) return false;
    if (!data.containsKey('rent_price') || data['rent_price'] <= 0)
      return false;
    if (!data.containsKey('is_available') || data['is_available'] <= 0)
      return false;
    return true;
  }
}
