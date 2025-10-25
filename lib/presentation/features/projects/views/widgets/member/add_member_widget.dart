import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/datasource/requests/add_member_request.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class AddMemberWidget extends StatelessWidget {
  const AddMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<ProjectBloc>().user;
    final projectModel = context.read<ProjectBloc>().projectModel ;
 final TextEditingController roleController = TextEditingController() ;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200.w),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
          child: Column(
            children: [
              ImagePlaceHolderWeb(
                radius: 35,
                fullName: user?.fullName ?? '',
                imageUrl: user?.imageUrl,
              ),
              const SizedBox(height: 20),
              Text(user?.fullName ?? ''),
              const SizedBox(height: 10),
              InputText(
                controller: roleController,
                hintText: "Role",
                prefixIcon: Image.asset(Assets.iconsAccessibility),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.w),
                child: BlocBuilder<ProjectBloc, ProjectState>(
                  builder: (context, state) {
                    if (state is AddMemberLoading) {
                      return Center(
                        child: Lottie.asset(
                          Assets.jsonLoadingDots,
                          height: 80,
                          width: 100,
                        ),
                      );
                    }
                    return CustomButton(
                      buttonColor: AppColors.primary500,
                      onPressed: () {
                         context.read<ProjectBloc>().add(AddMemberEvent(
                           AddMemberRequest(
                             user!.id!,
                             projectModel!.id!,
                             roleController.text,
                           )
                         ));
                      },
                      text: "Add Member",
                      textStyle:
                      sataoshiBold.copyWith(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
