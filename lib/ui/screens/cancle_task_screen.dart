import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bae.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {


  List<TaskModel> _cancelledTaskList = [];
  bool _isloading = false;

  Future<void> _getAllTasks() async {
    _isloading = true;
    setState(() {});

    final ApiResponse response =
    await ApiCaller.getRequest(url: Urls.cancelledTaskUrl);

    _isloading = false;
    setState(() {});
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    _cancelledTaskList = list;
  }

  @override
  void initState() {
    super.initState();
    _getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Visibility(
          visible: _isloading == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _cancelledTaskList[index],
                cardColor: Colors.blue,
                refreshParent: (){
                  _getAllTasks();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 4,
              );
            },
          ),
        ),
      ),
    );
  }
}
