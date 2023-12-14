import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/data/models/task_list_model.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTasks);
    if (response.isSuccess) {
      isSuccess = true;
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getProgressTaskInProgress = false;
    update();
    return isSuccess;
  }
}
