import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserWithScore {
  final String name;
  final int score;
  UserWithScore(this.name, this.score);
}

Future<void> saveNewLeader(UserWithScore leader) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference leaders = _firestore
      .collection('leaderBoardData')
      .doc('Omm5rjS6Jtxu8NxWMnZu')
      .collection('leaders');
  leaders.doc('leaders');
}

Future<List<dynamic>> loadLeaderBoardList() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final leaders = await _firestore
      .collection('leaderBoardData')
      .doc('Omm5rjS6Jtxu8NxWMnZu')
      .get();
  return leaders['leaders'];
}
