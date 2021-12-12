import 'package:flutter/material.dart';
import 'package:rusher/components/firestore/leaderboard_list.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'main_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeadersMenu extends StatelessWidget {
  static const id = 'LeaderssMenu';
  final Rusher gameRef;

  const LeadersMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuWrapper(
      menuItems: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${AppLocalizations.of(context)!.leaderBoard}: ',
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white60),
          ),
          const LeaderBoardList(),
          TextButton(
            onPressed: () {
              gameRef.overlays.remove(LeadersMenu.id);
              gameRef.overlays.add(MainMenu.id);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              Text(
                AppLocalizations.of(context)!.back,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
