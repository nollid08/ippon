import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/karate/kumite/scoring_system.dart';
import 'package:ippon/view/record-match/kumite/details.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CreateKumiteMatch extends StatefulWidget {
  const CreateKumiteMatch({super.key});

  @override
  _CreateKumiteMatchState createState() => _CreateKumiteMatchState();
}

class _CreateKumiteMatchState extends State<CreateKumiteMatch> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Kumite Match'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
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
              FormBuilderDateTimePicker(
                name: 'matchDate',
                decoration: InputDecoration(labelText: 'Match Date'),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Record Match'),
                  onPressed: () {
                    // // Validate and save the form values
                    bool? validated = _formKey.currentState?.saveAndValidate();
                    if (!validated!) {
                      return;
                    }
                    final formValue = _formKey.currentState?.value;
                    debugPrint(formValue.toString());
                    // final db = FirebaseFirestore.instance;
                    // db
                    //     .collection('users')
                    //     .doc('gBONifqYDpc0fUlRrEE025mJ92m1')
                    //     .collection('matches')
                    //     .add(formValue!);
                    final String title = formValue?['title'];
                    final String description = formValue?['description'];
                    final String opponent = formValue?['opponent'];
                    final DateTime matchDate = formValue?['matchDate'];

                    final KumiteMatch match = KumiteMatch(
                      title: title,
                      description: description,
                      opponent: opponent,
                      dateTime: matchDate,
                      scoringSystem: ScoringSystems.IJKA,
                    );
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DetailKumiteMatch(
                        match: match,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
