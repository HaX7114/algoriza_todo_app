import 'package:algoriza_todo_app/presentation/add_task/add_task.dart';
import 'package:algoriza_todo_app/presentation/board/all/view_all_tasks.dart';
import 'package:algoriza_todo_app/presentation/board/favorite/view_favorite_tasks.dart';
import 'package:algoriza_todo_app/presentation/board/uncompleted/view_uncompleted_tasks.dart';
import 'package:algoriza_todo_app/presentation/board/widgets/actions_icons.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/bottom_button.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/utils/functions/navigation_functions.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'completed/view_completed_tasks.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Board',
                      size: fontSizeL + 3,
                      fontWeight: FontWeight.w600,
                    ),
                    const ActionsIcons(),
                  ],
                ),
              ),
              K_vSpace10,
              Container(
                color: blackColor.withOpacity(0.2),
                width: double.infinity,
                height: 1.0,
              ),
              K_vSpace10,
              K_vSpace10,
              K_vSpace10,
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: blackColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 11.0),
            labelStyle: GoogleFonts.poppins(
              fontSize: fontSizeM - 2,
              color: blackColor,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Colors.black38,
            indicatorColor: blackColor,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Uncompleted',
              ),
              Tab(
                text: 'Favorite',
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                ViewAllTasks(),
                ViewCompletedTasks(),
                ViewUncompletedTasks(),
                ViewFavoriteTasks()
              ],
            ),
            ButtomButton(
              buttonText: 'Add a task',
              onPressed: () {
                navigateTo(context, AddTask());
              },
            ),
          ],
        ),
      ),
    );
  }
}
