import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RecordMatch extends StatefulWidget {
  const RecordMatch({super.key});

  @override
  State<RecordMatch> createState() => _RecordMatchState();
}

class _RecordMatchState extends State<RecordMatch> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final titleFieldKey = GlobalKey<FormBuilderFieldState>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                key: titleFieldKey,
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'opponent',
                decoration: const InputDecoration(labelText: 'Opponent'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderSwitch(
                  name: 'wasWon', title: Text('Won?'), initialValue: false),
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  // Validate and save the form values
                  formKey.currentState?.saveAndValidate();
                  final formValue = formKey.currentState?.value;
                  debugPrint(formValue.toString());
                  final db = FirebaseFirestore.instance;
                  db
                      .collection('users')
                      .doc('gBONifqYDpc0fUlRrEE025mJ92m1')
                      .collection('matches')
                      .add(formValue!);
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
