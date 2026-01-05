import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_priority_card.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_status_card.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

import '../../../../theme/colors.dart';

class TasksDataTable extends StatefulWidget {
  const TasksDataTable({super.key});

  @override
  State<TasksDataTable> createState() => _TasksDataTableState();
}

class _TasksDataTableState extends State<TasksDataTable> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add(GetTasksEvent(PaginationRequest(0, 4)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      buildWhen: (previous, current) => current is GetTasksSuccess || current is GetTasksFailure || current is GetTasksLoading,
      builder: (context, state) {
        if (state is GetTasksLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetTasksFailure) {
          return Center(child: Text("Error: ${state.failure.message}"));
        }
        if (state is GetTasksSuccess) {
          final tasks = state.response.data;
          final totalPages = state.response.pagination.totalPages;
          final currentPage = state.response.pagination.currentPage;
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryGrey),
                  color: Colors.white,
                ),
                child: DataTable(
                  headingRowHeight: 55,
                  dataRowHeight: 68,
                  horizontalMargin: 24,
                  columnSpacing: 60,
                  dividerThickness: 0.4,
                  columns: [
                    DataColumn(
                        label: Text(
                      "Task",
                      style: sataoshiBold.copyWith(fontSize: 17),
                    )),
                    DataColumn(
                      label: Text(
                        "Priority",
                        style: sataoshiBold.copyWith(fontSize: 17),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Status",
                        style: sataoshiBold.copyWith(fontSize: 17),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Assignee",
                        style: sataoshiBold.copyWith(fontSize: 17),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Deadline",
                        style: sataoshiBold.copyWith(fontSize: 17),
                      ),
                    )
                  ],
                  rows: tasks.map((task) {
                    return DataRow(cells: [
                      DataCell(Text(
                        task.name!,
                        style: sataoshiRegular.copyWith(fontSize: 15),
                      )),
                      DataCell(TaskPriorityCard(
                        taskPriorityModel: TaskPriorityModel.type(task.priority!),
                      )),
                      DataCell(TaskStatusCard(
                        taskStatusModel: TaskStatusModel.status(task.status!),
                      )),
                      DataCell(Row(
                        children: [
                          ImagePlaceHolderWeb(
                              radius: 10,
                              fullName: task.assignedUser!.fullName!,
                              imageUrl: task.assignedUser!.imageUrl),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            task.assignedUser!.fullName!,
                            style: sataoshiRegular.copyWith(fontSize: 15),
                          )
                        ],
                      )) ,
                      DataCell(Text(task.deadline! ,style: sataoshiRegular.copyWith(fontSize: 15 ,color: Colors.redAccent),) )

                    ]);
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              NumberPagination(
                buttonRadius: 180,
                selectedButtonColor: AppColors.primary500,
                totalPages: totalPages,
                currentPage: currentPage + 1,
                onPageChanged: (page) {
                  _taskBloc.add(GetTasksEvent(PaginationRequest(page - 1, 4)));
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
