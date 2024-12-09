import 'package:property/repository/property_client.dart';
import '../model/properties_response.dart';

class PropertyRepository {
  final PropertyClient propertyClient;

  PropertyRepository(this.propertyClient);

  Future<List<Property>> getProperties() async {
    try {
      return await propertyClient.getProperties();
    } catch (error) {
      throw Exception('Failed to fetch properties: $error');
    }
  }

  Future<Property> createProperty(Map<String, dynamic> propertyData) async {
    try {
      return await propertyClient.createProperty(propertyData);
    } catch (error) {
      throw Exception('Failed to create property: $error');
    }
  }

  Future<Property> updateProperty(
      num id, Map<String, dynamic> updatedData) async {
    try {
      return await propertyClient.updateProperty(id, updatedData);
    } catch (error) {
      throw Exception('Failed to update property: $error');
    }
  }
}
