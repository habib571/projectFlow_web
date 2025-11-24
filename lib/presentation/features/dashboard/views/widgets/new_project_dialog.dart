import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

Future<void> showCreateProjectDialog(BuildContext context) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final  TextEditingController dateController = TextEditingController() ;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider(
  create: (context) =>  getIt.get<ProjectBloc>() ,
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
                Text('Project Name',
                    style: sataoshiBold.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                InputText(
                  controller: nameController,
                  hintText: 'Enter project name',
                ),
                const SizedBox(height: 16),

                // Description
                Text('Description',
                    style: sataoshiBold.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                InputText(
                  controller: descriptionController,
                  hintText: 'Enter project description',
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                Text('Due Date',
                    style: sataoshiBold.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    return InputText(
                      readOnly: true,
                      controller: dateController ,
                      suffixIcon:const  Icon(Icons.calendar_month_outlined),
                      onTap: () async {
                        await pickProjectEndDate(context , dateController);
                      },
                    );
                  }
                ),
                BlocConsumer<ProjectBloc, ProjectState>(
                  listener: (context, state) {
                   if(state is CreateProjectSuccess) {
                     Navigator.pop(context);
                   }

                  },
                  builder: (context, state) {
                    if(state is CreateProjectLoading) {
                      return Center(
                        child: Lottie.asset(Assets.jsonLoadingDots , height: 150 , width: 200),
                      );
                    } else if(state is CreateProjectFailure) {
                      return Text(state.failure.message ,style: sataoshiRegular.copyWith(fontSize: 13 ,color: Colors.redAccent),);
                    }
                    return Row(
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
                            onPressed: () {
                              context.read<ProjectBloc>().add(
                                  CreateProjectEvent(
                                      ProjectModel.request(title: nameController.text, description: descriptionController.text ,dueDate: dateController.text)
                                  )
                              ) ;
                            },
                            text: "Create Project",
                            textStyle: sataoshiBold.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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

pickProjectEndDate(BuildContext context , TextEditingController dateController) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (pickedDate != null) {
    selectedDate = pickedDate.toString();
    dateController.text =
    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
  }
}