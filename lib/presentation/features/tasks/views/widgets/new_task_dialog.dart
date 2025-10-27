import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/select_member_widget.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/task_priority_chip.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

Future<void> showCreateTaskDialog(BuildContext context,
    List<MemberModel> members) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider(
        create: (context) => getIt.get<TaskBloc>(),
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: 600.w,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create New Project',
                        style: sataoshiBold.copyWith(fontSize: 22),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Project Name
                  Text('Project Name',
                      style: sataoshiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  InputText(
                    controller: nameController,
                    hintText: 'Enter project name',
                  ),
                  const SizedBox(height: 16),

                  Text('Description',
                      style: sataoshiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  InputText(
                    controller: descriptionController,
                    hintText: 'Enter project description',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Priority',
                                style: sataoshiBold.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            BlocBuilder<TaskBloc, TaskState>(
                              builder: (context, state) {
                                final selectedIndex = state is PrioritySelected
                                    ? state.selectedIndex
                                    : -1;

                                return Wrap(
                                  spacing: 8,
                                  children: List.generate(4, (index) {
                                    return TaskPriorityChip(
                                      chipModel: ChipModel(
                                        priorityChipTexts[index],
                                        index == selectedIndex,
                                        priorityTextColors[index],
                                        priorityChipColors[index],
                                      ),
                                      onSelect: (_) {
                                        context
                                            .read<TaskBloc>()
                                            .add(SelectPriority(index));
                                      },
                                    );
                                  }),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Due Date',
                                style: sataoshiBold.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            InputText(
                              readOnly: true,
                              controller: deadlineController,
                              suffixIcon:
                              const Icon(Icons.calendar_month_outlined),
                              onTap: () async {
                                await pickProjectEndDate(
                                    context, deadlineController);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          buttonColor: AppColors.primaryGrey,
                          onPressed: () => Navigator.pop(context),
                          text: "Cancel",
                          textStyle: sataoshiBold.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          buttonColor: AppColors.primary500,
                          onPressed: () {},
                          text: "Create Project",
                          textStyle: sataoshiBold.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SelectMemberWidget(members: members)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

String? selectedDate;

Future<void> pickProjectEndDate(BuildContext context,
    TextEditingController dateController) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (pickedDate != null) {
    selectedDate = pickedDate.toString();
    dateController.text =
    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month
        .toString()
        .padLeft(2, '0')}-${pickedDate.year}";
  }
}
