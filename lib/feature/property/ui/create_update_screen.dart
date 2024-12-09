import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/properties_response.dart';
import '../bloc/property_bloc.dart';
import '../bloc/property_retrieval_event.dart';
import '../bloc/property_state.dart';

class CreateUpdateScreen extends StatefulWidget {
  final Property? property;

  const CreateUpdateScreen({super.key, this.property});

  @override
  State<CreateUpdateScreen> createState() => _CreateUpdateScreenState();
}

class _CreateUpdateScreenState extends State<CreateUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _rentPriceController = TextEditingController();
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();

    if (widget.property != null) {
      _titleController.text = widget.property?.title ?? '';
      _descriptionController.text = widget.property?.description ?? '';
      _locationController.text = widget.property?.location ?? '';
      _rentPriceController.text = widget.property?.rentPrice?.toString() ?? '';
      _isAvailable = widget.property?.isAvailable == 1;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _rentPriceController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final property = Property(
        id: widget.property?.id,
        // Use existing ID for updates
        title: _titleController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        rentPrice: double.tryParse(_rentPriceController.text) ?? 0.0,
        isAvailable: _isAvailable ? 1 : 0,
      );

      if (widget.property == null) {
        // Create new property
        context
            .read<PropertySearchBloc>()
            .add(PropertyAdded(property: property));
      } else {
        // Update existing property
        context
            .read<PropertySearchBloc>()
            .add(PropertyUpdated(property: property));
      }

      // Navigate back to the previous screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.property == null ? 'Create Property' : 'Update Property'),
      ),
      body: BlocListener<PropertySearchBloc, PropertyState>(
        listener: (context, state) {
          if (state is PropertyStateLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is PropertyStateSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); // Close the loading dialog
            Navigator.of(context).pop(); // Navigate back to the previous screen
          } else if (state is PropertyStateError) {
            Navigator.of(context, rootNavigator: true).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Location is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _rentPriceController,
                    decoration: const InputDecoration(labelText: 'Rent Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rent Price is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text('Is Available'),
                      Switch(
                        value: _isAvailable,
                        onChanged: (value) {
                          setState(() {
                            _isAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _handleSubmit(context),
                      child: Text(widget.property == null
                          ? 'Create Property'
                          : 'Update Property'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
