import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/cancelled_task_controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      isSuccess = true;
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCompletedTaskInProgress = false;
    update();

    return isSuccess;
  }
}
