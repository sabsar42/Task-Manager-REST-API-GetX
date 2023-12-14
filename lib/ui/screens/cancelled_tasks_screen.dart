import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/cancelled_task_controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    _cancelledTaskController.getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummaryCard(),
          Expanded(
            child: GetBuilder<CancelledTaskController>(builder: (context) {
              return Visibility(
                visible:
                    _cancelledTaskController.getCancelledTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: _cancelledTaskController.getCancelledTaskList,
                  child: ListView.builder(
                    itemCount: _cancelledTaskController
                            .taskListModel.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: _cancelledTaskController
                            .taskListModel.taskList![index],
                        onStatusChange: () {
                          _cancelledTaskController.getCancelledTaskList();
                        },
                        showProgress: (inProgress) {},
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ));
  }
}
