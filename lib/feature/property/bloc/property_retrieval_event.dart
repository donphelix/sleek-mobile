import 'package:equatable/equatable.dart';

import '../../../../model/properties_response.dart';

abstract class PropertyRetrievalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPropertiesEvent extends PropertyRetrievalEvent {
  @override
  String toString() => 'FetchPropertiesEvent';
}

class PropertyUpdated extends PropertyRetrievalEvent {
  final Property property;

  PropertyUpdated({required this.property});

  @override
  List<Object> get props => [property];

  @override
  String toString() => "PropertyUpdated { property: $property }";
}

class PropertyAdded extends PropertyRetrievalEvent {
  final Property property;

  PropertyAdded({required this.property});

  @override
  List<Object> get props => [property];

  @override
  String toString() => "PropertyAdded { property: $property }";
}
