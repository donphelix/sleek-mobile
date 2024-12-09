import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property/feature/property/bloc/property_retrieval_event.dart';
import 'package:property/feature/property/bloc/property_state.dart';
import 'package:property/repository/property_repository.dart';

class PropertySearchBloc extends Bloc<PropertyRetrievalEvent, PropertyState> {
  final PropertyRepository propertyRepository;

  PropertySearchBloc(this.propertyRepository) : super(PropertyStateEmpty()) {
    on<PropertyUpdated>(_onPropertyUpdated);
    on<PropertyAdded>(_onPropertyAdded);
    on<FetchPropertiesEvent>(_onFetchProperties);
  }

  Future<void> _onPropertyUpdated(
      PropertyUpdated event, Emitter<PropertyState> emit) async {
    try {
      emit(PropertyStateLoading());
      await propertyRepository.updateProperty(
          event.property.id ?? 0, event.property.toJson());
      final properties = await propertyRepository.getProperties();
      emit(PropertyStateSuccess(properties));
    } catch (error) {
      emit(PropertyStateError(error.toString()));
    }
  }

  Future<void> _onPropertyAdded(
      PropertyAdded event, Emitter<PropertyState> emit) async {
    try {
      emit(PropertyStateLoading());
      await propertyRepository.createProperty(event.property.toJson());
      final properties = await propertyRepository.getProperties();
      emit(PropertyStateSuccess(properties));
    } catch (error) {
      emit(PropertyStateError(error.toString()));
    }
  }

  Future<void> _onFetchProperties(
      FetchPropertiesEvent event, Emitter<PropertyState> emit) async {
    try {
      emit(PropertyStateLoading());
      final properties = await propertyRepository.getProperties();
      emit(PropertyStateSuccess(properties));
    } catch (error) {
      emit(PropertyStateError(error.toString()));
    }
  }
}
