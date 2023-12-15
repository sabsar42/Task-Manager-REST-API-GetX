import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_caller.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_response.dart';
import 'package:task_manager_project_rest_api/data/utility/urls.dart';
import 'package:task_manager_project_rest_api/ui/controllers/new_task_controller.dart';
import 'package:task_manager_project_rest_api/ui/controllers/tasks_count_summary_list_controller.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:task_manager_project_rest_api/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_project_rest_api/ui/widgets/snack_message.dart';
import 'package:get/get.dart';

class AddNewTaskController extends GetxController {
  bool _createTaskInProgress = false;
  bool _newTaskAdd = false;
  String _message = '';

  bool get createTaskInProgress => _createTaskInProgress;
  bool get newTaskAdd => _newTaskAdd;
  String get message => _message;

  Future<bool> createTask(String subject, String description) async {
    _createTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createNewTask,
        body: {"title": subject, "description": description, "status": "New"});
    _createTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _newTaskAdd = true;
      Get.find<NewTaskController>().getNewTaskList();
      Get.find<TaskCountSummaryListController>().getTaskCountSummaryList();
      _message = 'New task added!';
      return true;
    } else {
      _message = 'Create new task failed! Try again.';
      return false;
    }
  }
}
