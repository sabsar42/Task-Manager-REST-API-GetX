import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/data/models/task_count.dart';
import 'package:task_manager_project_rest_api/data/models/task_list_model.dart';
import 'package:task_manager_project_rest_api/data/models/task_count_summary_model.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_caller.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_response.dart';
import 'package:task_manager_project_rest_api/ui/controllers/new_task_controller.dart';
import 'package:task_manager_project_rest_api/ui/screens/add_new_tasks_screen.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class TaskCountSummaryListController extends GetxController {
  bool _getTaskCountSummaryInProgress = false;
  TaskCountSummaryListModel _taskCountSummaryListModel =
  TaskCountSummaryListModel();
  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;

  TaskCountSummaryListModel get taskCountSummaryListModel =>
      _taskCountSummaryListModel;

  Future<bool> getTaskCountSummaryList() async {
    bool isSuccess = false;
    _getTaskCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    _getTaskCountSummaryInProgress = false;
    update();
    return isSuccess;
  }
}
