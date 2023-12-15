import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/completed_task_controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    _completedTaskController.getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummaryCard(),
          GetBuilder<CompletedTaskController>(
              builder: (completedTaskController) {
            return Expanded(
              child: Visibility(
                visible:
                    completedTaskController.getCompletedTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: completedTaskController.getCompletedTaskList,
                  child: ListView.builder(
                    itemCount: completedTaskController
                            .taskListModel.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: completedTaskController
                            .taskListModel.taskList![index],
                        onStatusChange: () {
                          completedTaskController.getCompletedTaskList();
                        },
                        showProgress: (inProgress) {},
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ));
  }
}
