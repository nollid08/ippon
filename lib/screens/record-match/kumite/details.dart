import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/result.dart';
import 'package:ippon/model/score.dart';
import 'package:ippon/model/scoring_system.dart';
import 'package:ippon/model/targets.dart';
import 'package:ippon/model/techniques.dart';
import 'package:ippon/model/match.dart';

class DetailKumiteMatch extends StatefulWidget {
  const DetailKumiteMatch({
    super.key,
    required this.match,
  });

  final Match match;
  @override
  State<DetailKumiteMatch> createState() => _DetailKumiteMatchState();
}

class _DetailKumiteMatchState extends State<DetailKumiteMatch> {
  final _formKey = GlobalKey<FormBuilderState>();
  Match? match;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final scoresToWin = match!.scoringSystem.system.scoresToWin;
    if (match!.homeScore >= scoresToWin || match!.awayScore >= scoresToWin) {
      completed = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumite Match Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Text('Title: ${match!.title}'),
            Text('Description: ${match!.description}'),
            Text('Opponent: ${match!.opponent}'),
            Text('Match Date: ${match!.dateTime}'),
            Text('Points System: ${match!.scoringSystem.system.title}'),
            ListView(
              shrinkWrap: true,
              children: match!.scores.map<Widget>((score) {
                Techniques technique = score.technique;
                String techniqueName = technique.data.japaneseName;
                Targets target = score.target;
                String targetName = target.info.japaneseName;
                return ListTile(
                  title:
                      Text('${score.type.name} - $techniqueName $targetName'),
                  subtitle: Text(score.description),
                  trailing: Text(score.homeScored ? 'Me' : match!.opponent),
                );
              }).toList(),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Me: ${match!.homeScore}'),
                  ],
                ),
                Column(
                  children: [
                    Text('${match!.opponent}: ${match!.awayScore}'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FilledButton.icon(
            onPressed: completed
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final ScoringSystem scoringSystem =
                            match!.scoringSystem.system;
                        return Dialog(
                          child: FormBuilder(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FormBuilderDropdown(
                                      name: 'Score',
                                      decoration: const InputDecoration(
                                          labelText: 'Score'),
                                      items: scoringSystem.scoreTypes
                                          .map((scoreType) {
                                        return DropdownMenuItem(
                                          value: scoreType,
                                          child: Text(scoreType.name),
                                        );
                                      }).toList()),
                                  FormBuilderDropdown<Techniques>(
                                    name: 'Technique',
                                    decoration: const InputDecoration(
                                        labelText: 'Technique'),
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
                                    decoration: const InputDecoration(
                                        labelText: 'Target'),
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
                                    decoration: const InputDecoration(
                                      labelText: 'Description',
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                  FormBuilderChoiceChip<String>(
                                      decoration: const InputDecoration(
                                          labelText: 'Who Scored?',
                                          border: InputBorder.none),
                                      name: 'whoScored',
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      options: [
                                        const FormBuilderChipOption(
                                          value: 'me',
                                          child: Text('Me'),
                                        ),
                                        FormBuilderChipOption(
                                          value: 'opponent',
                                          child: Text(match!.opponent),
                                        ),
                                      ]),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.save),
                                    label: const Text('Save'),
                                    onPressed: () {
                                      // // Validate and save the form values
                                      bool? isValid = _formKey.currentState
                                          ?.saveAndValidate();
                                      if (isValid!) {
                                        setState(() {
                                          final Score score = Score(
                                            index: match!.scores.length,
                                            type: _formKey
                                                .currentState?.value['Score'],
                                            technique: _formKey.currentState
                                                ?.value['Technique'],
                                            target: _formKey
                                                .currentState?.value['Target'],
                                            description: _formKey.currentState
                                                ?.value['description'],
                                            homeScored: _formKey.currentState
                                                    ?.value['whoScored'] ==
                                                'me',
                                          );

                                          match!.addScore(score);
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
            icon: const Icon(Icons.add),
            label: const Text('Add Score')),
        FilledButton.icon(
            onPressed: () async {
              if (match!.scores.isEmpty) {
                return;
              }

              final db = FirebaseFirestore.instance;
              final batch = db.batch();
              final DocumentReference<Map<String, dynamic>> matchDoc = db
                  .collection('users')
                  .doc('gBONifqYDpc0fUlRrEE025mJ92m1')
                  .collection('matches')
                  .doc();

              final Map<String, dynamic> matchData = {
                'title': match!.title,
                'description': match!.description,
                'opponent': match!.opponent,
                'dateTime': match!.dateTime,
                'scoringSystem': match!.scoringSystem.system.title,
                'type': match!.type,
                'homeScore': match!.homeScore,
                'awayScore': match!.awayScore,
                'result': match!.result.toString(),
              };

              batch.set(matchDoc, matchData);

              for (Score score in match!.scores) {
                final DocumentReference<Map<String, dynamic>> scoreDoc =
                    matchDoc.collection('scores').doc();

                final Map<String, dynamic> scoreData = {
                  'index': score.index,
                  'type': score.type.name,
                  'technique': score.technique.data.japaneseName,
                  'target': score.target.info.japaneseName,
                  'description': score.description,
                  'homeScored': score.homeScored,
                };

                batch.set(scoreDoc, scoreData);
              }

              await batch.commit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Record Match')),
      ],
    );
  }
}
