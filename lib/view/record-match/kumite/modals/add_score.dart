import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/karate/kumite/score.dart';
import 'package:ippon/model/karate/kumite/scoring_system.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:ippon/model/karate/kumite/targets.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';

class AddScore extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final void Function(Score) onSubmit;
  final KumiteMatch match;
  final ScoringSystem scoringSystem;

  AddScore({
    super.key,
    required this.onSubmit,
    required this.match,
  }) : scoringSystem = match.scoringSystem.system;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Score', textAlign: TextAlign.center),
      content: FormBuilder(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 425),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderDropdown(
                  name: 'Score',
                  decoration: const InputDecoration(labelText: 'Score'),
                  validator: FormBuilderValidators.required(),
                  items: scoringSystem.scoreTypes.map((scoreType) {
                    return DropdownMenuItem(
                      value: scoreType,
                      child: Text(scoreType.name),
                    );
                  }).toList()),
              FormBuilderDropdown<Techniques>(
                name: 'Technique',
                decoration: const InputDecoration(labelText: 'Technique'),
                validator: FormBuilderValidators.required(),
                items: Techniques.values.map((technique) {
                  return DropdownMenuItem<Techniques>(
                    value: technique,
                    child: Text(
                        '${technique.data.japaneseName} - ${technique.data.englishName}'),
                  );
                }).toList(),
              ),
              FormBuilderDropdown<Targets>(
                name: 'Target',
                decoration: const InputDecoration(labelText: 'Target'),
                validator: FormBuilderValidators.required(),
                items: Targets.values.map((target) {
                  return DropdownMenuItem<Targets>(
                    value: target,
                    child: Text(
                        '${target.info.japaneseName} - ${target.info.englishName}'),
                  );
                }).toList(),
              ),
              FormBuilderTextField(
                name: 'description',
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              FormBuilderChoiceChip<String>(
                  decoration: const InputDecoration(
                      labelText: 'Who Scored?', border: InputBorder.none),
                  name: 'whoScored',
                  crossAxisAlignment: WrapCrossAlignment.center,
                  validator: FormBuilderValidators.required(),
                  options: [
                    const FormBuilderChipOption(
                      value: 'me',
                      child: Text('Me'),
                    ),
                    FormBuilderChipOption(
                      value: 'opponent',
                      child: Text(match.opponent),
                    ),
                  ]),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Save'),
          onPressed: submit,
        ),
      ],
    );
  }

  void submit() {
    // // Validate and save the form values
    bool? isValid = _formKey.currentState?.saveAndValidate();
    if (!isValid!) {
      return;
    }
    final Score score = Score(
      type: _formKey.currentState?.value['Score'],
      technique: _formKey.currentState?.value['Technique'],
      target: _formKey.currentState?.value['Target'],
      description: _formKey.currentState?.value['description'],
      homeScored: _formKey.currentState?.value['whoScored'] == 'me',
    );
    onSubmit(score);
  }
}
