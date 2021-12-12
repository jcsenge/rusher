import 'package:cloud_firestore/cloud_firestore.dart';

class UserWithScore {
  final String name;
  final int score;
  UserWithScore(this.name, this.score);
}

Future<void> saveNewLeader(UserWithScore leader) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final leaders = await loadLeaderBoardList();
  if (leaders.length >= 10) {
    leaders.remove(leaders.last);
  }
  leaders.add({"name": leader.name, "score": leader.score});
  await _firestore
      .collection('leaderBoardData')
      .doc('Omm5rjS6Jtxu8NxWMnZu')
      .set({"leaders": leaders});
}

Future<List<dynamic>> loadLeaderBoardList() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final leaders = await _firestore
      .collection('leaderBoardData')
      .doc('Omm5rjS6Jtxu8NxWMnZu')
      .get();
  return leaders['leaders'];
}
