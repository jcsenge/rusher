import 'package:flutter/material.dart';
import 'package:rusher/components/firestore/firestore.dart';

class LeaderBoardList extends StatefulWidget {
  const LeaderBoardList({Key? key}) : super(key: key);

  @override
  _LeaderBoardListState createState() => _LeaderBoardListState();
}

class _LeaderBoardListState extends State<LeaderBoardList> {
  Future<List<dynamic>> getLeaders() async => await loadLeaderBoardList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 100,
        child: FutureBuilder(
            future: getLeaders(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      shrinkWrap: false,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            title: Text(
                              "${(index + 1).toString()}. ${snapshot.data![index]["name"].toString()}: ${snapshot.data![index]["score"].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white60,
                                  fontSize: 22),
                            ),
                          ),
                        );
                      });
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
