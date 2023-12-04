import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  bool getCompletedTaskInProgress = false;
  bool getUpdateProfileSummaryCard = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCompletedTaskList() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> getUpdateProfileSummaryCard() async {
  //   getUpdateProfileSummaryCardInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   final NetworkResponse response =
  //   await NetworkCaller().getRequest(Urls.getCompletedTasks);
  //   if (response.isSuccess) {
  //     taskListModel = TaskListModel.fromJson(response.jsonResponse);
  //   }
  //   getCompletedTaskInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    getCompletedTaskList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileSummaryCard(),
          Expanded(
            child: Visibility(
              visible: getCompletedTaskInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: RefreshIndicator(
                onRefresh: getCompletedTaskList,
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                      onStatusChange: () {
                        getCompletedTaskList();
                      },
                      showProgress: (inProgress) {
                        getCompletedTaskInProgress = inProgress;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
