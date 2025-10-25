import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/member/add_member_widget.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/member/search_member_section.dart';
import 'package:step_progress/step_progress.dart';
class InviteMemberScreen extends StatefulWidget {
  const InviteMemberScreen({super.key});

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  final _stepProgressController = StepProgressController(totalSteps: 3);
  late  ProjectBloc bloc ;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProjectBloc>();
    _stepProgressController.addListener(() {
      bloc.currentStep= _stepProgressController.currentStep;

    });
  }

  Widget _buildStepContent(BuildContext context, int step) {
    final bloc = context.read<ProjectBloc>();
    switch (step) {
      case 0:
        return SearchMemberSection(
          onUserTap: () => bloc.add(const ChangeStepEvent(1)),
        );
      case 1:
        return const AddMemberWidget();
      case 2:
        return const Text("Step 3: Confirm Invitation");
      default:
        return const Text("Something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        final bloc = context.read<ProjectBloc>();
        final currentStep = (state is StepChanged)
            ? state.step
            : bloc.currentStep;
        if (_stepProgressController.currentStep != currentStep) {
          _stepProgressController.nextStep() ;
        }

        return Card(
          elevation: 1,
          color: Colors.white,
          child: Column(
            children: [
              StepProgress(
                margin: EdgeInsets.symmetric(horizontal: 150.w, vertical: 40),
                controller: _stepProgressController,
                totalSteps: 3,
                onStepChanged: (index)  {
                  bloc.add(ChangeStepEvent(index)) ;

                }
              ),
              _buildStepContent(context, currentStep),
            ],
          ),
        );
      },
    );
  }
}
