import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/clubs/club.dart';
import 'package:ippon/model/clubs/club_types.dart';

class AddClub extends StatefulWidget {
  const AddClub({
    super.key,
  });

  @override
  State<AddClub> createState() => _AddClubState();
}

class _AddClubState extends State<AddClub> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    return isSubmitting
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AlertDialog(
            title: const Text(
              'Add Club',
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 250,
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'description',
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      initialValue: null,
                    ),
                    FormBuilderDropdown(
                      name: 'type',
                      decoration: const InputDecoration(labelText: 'Type'),
                      validator: FormBuilderValidators.required(),
                      items: ClubTypes.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  bool? isValid = _formKey.currentState?.saveAndValidate();
                  if (!isValid!) {
                    return;
                  }
                  setState(() {
                    isSubmitting = true;
                  });
                  await Club.create(
                    name:
                        _formKey.currentState!.fields['name']!.value as String,
                    description: _formKey
                        .currentState!.fields['description']!.value as String,
                    type: _formKey.currentState!.fields['type']!.value
                        as ClubTypes,
                  );
                  setState(() {
                    isSubmitting = false;
                  });
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
  }
}
