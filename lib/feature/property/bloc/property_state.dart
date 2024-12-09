import 'package:equatable/equatable.dart';
import 'package:property/model/properties_response.dart';

abstract class PropertyState extends Equatable {
  @override
  List<Object> get props => [];
}

class PropertyStateEmpty extends PropertyState {
  @override
  String toString() => 'PropertyStateEmpty';
}

class PropertyStateLoading extends PropertyState {
  @override
  String toString() => 'PropertyStateLoading';
}

class PropertyStateSuccess extends PropertyState {
  final List<Property> properties;

  PropertyStateSuccess(this.properties);

  @override
  List<Object> get props => [properties];

  @override
  String toString() => 'PropertyStateSuccess { properties: ${properties.length} }';
}

class PropertyStateError extends PropertyState {
  final String error;

  PropertyStateError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PropertyStateError { error: $error }';
}