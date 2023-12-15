import 'package:get/get.dart';
import 'package:task_manager_project_rest_api/ui/controllers/tasks_count_summary_list_controller.dart';

import '../../data/models/task_count_summary_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTasks);
    _getNewTaskInProgress = false;
    if (response.isSuccess) {
      Get.find<TaskCountSummaryListController>().getTaskCountSummaryList();
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }

    update();
    return isSuccess;
  }
}
