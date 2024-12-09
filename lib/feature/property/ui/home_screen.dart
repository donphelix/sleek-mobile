import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/property_bloc.dart';
import '../bloc/property_retrieval_event.dart';
import '../bloc/property_state.dart';
import 'create_update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Properties"),
      ),
      body: BlocBuilder<PropertySearchBloc, PropertyState>(
        builder: (BuildContext context, PropertyState state) {
          if (state is PropertyStateEmpty) {
            context.read<PropertySearchBloc>().add(FetchPropertiesEvent());
          }

          if (state is PropertyStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PropertyStateError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is PropertyStateSuccess) {
            if (state.properties.isEmpty) {
              return const Center(
                child: Text("No properties found"),
              );
            }
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                var property = state.properties[index];
                return ListTile(
                  title: Text(property.title ?? 'No Title'),
                  subtitle: Text(property.description ?? 'No Description'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateUpdateScreen(property: property),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("There was a problem while fetching properties"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateUpdateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
