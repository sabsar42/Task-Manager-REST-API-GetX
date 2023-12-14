import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_caller.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_response.dart';
import 'package:task_manager_project_rest_api/data/utility/urls.dart';
import 'package:task_manager_project_rest_api/ui/controllers/new_task_controller.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:task_manager_project_rest_api/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_project_rest_api/ui/widgets/snack_message.dart';
import 'package:get/get.dart';
import '../controllers/add_new_task_controller.dart';
import 'main_bottom_nav_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _addNewTaskController.newTaskAdd);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Add New Task',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _subjectTEController,
                              decoration:
                                  const InputDecoration(hintText: 'Subject'),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Enter your subject';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _descriptionTEController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                  hintText: 'Description'),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Enter your description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: GetBuilder<AddNewTaskController>(
                                builder: (addNewTaskController) {
                                  return Visibility(
                                    visible: addNewTaskController.createTaskInProgress == false,
                                    replacement: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: createTask,
                                      child: const Icon(Icons.arrow_forward_ios),
                                    ),
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _addNewTaskController.createTask(
        _subjectTEController.text, _descriptionTEController.text);

    if (response) {
    //  _addNewTaskController.newTaskAdd = _addNewTaskController.newTaskAdd;
      _clearTextFields();
      if (mounted) {
        showSnackMessage(context, _addNewTaskController.message);
        Get.offAll(const  MainBottomNavScreen());
      }
    } else {
      if (mounted) {
        showSnackMessage(context, _addNewTaskController.message);
      }
    }
  }

  void _clearTextFields() {
    _descriptionTEController.clear();
    _subjectTEController.clear();
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
