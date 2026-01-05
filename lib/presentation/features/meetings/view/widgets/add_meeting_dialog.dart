
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/meetings/view/widgets/participant_chip.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../../datasource/requests/add_meeting_request.dart';
import '../../../../../domain/models/meeting.dart';
import '../../meetingbloc/meeting_bloc.dart';

Future<void> showCreateMeetingDialog(BuildContext context) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextfieldTagsController<String> tagController = TextfieldTagsController<String>();


  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider.value(
        value: getIt.get<MeetingBloc>() ,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: 650.w,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Create New Meeting',
                          style: sataoshiBold.copyWith(fontSize: 22)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name
                  Text('Meeting Name',
                      style: sataoshiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  InputText(
                    controller: nameController,
                    hintText: 'Enter meeting name',
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date',
                                style: sataoshiBold.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            InputText(
                              controller: dateController,
                              readOnly: true,
                              suffixIcon:
                              const Icon(Icons.calendar_today_outlined),
                              onTap: () => pickProjectEndDate(
                                  context, dateController),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Start Time',
                                style: sataoshiBold.copyWith(fontSize: 16)),
                            const SizedBox(height: 8),
                            InputText(
                              controller: timeController,
                              readOnly: true,
                              suffixIcon:
                              const Icon(Icons.access_time_outlined),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  selectedTime = pickedTime;
                                  timeController.text =
                                  "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute
                                      .toString().padLeft(2, '0')}";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Duration as TEXTFIELD
                  Text('Duration',
                      style: sataoshiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  InputText(
                    controller: durationController,
                    hintText: 'e.g. 30 minutes',
                  ),

                  const SizedBox(height: 24),

                  Text('Invite Participants', style: sataoshiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),

                  BlocBuilder<MeetingBloc, MeetingState>(
                    buildWhen: (prev, curr) => curr is ParticipantsState,
                    builder: (context, state) {
                      final selected = state is ParticipantsState ? state.selected : [];

                      return Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selected.map((member) {
                          return ParticipantChip(
                            imageUrl: member.user!.imageUrl!,
                            userName: member.user!.fullName!,
                            onDeleted: () {
                              context.read<MeetingBloc>().add(RemoveParticipant(member));
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),


                  const SizedBox(height: 8),

                  Builder(
                    builder: (context) {
                      return TextField(
                        controller: participantsController,
                        decoration: const InputDecoration(
                          hintText: 'Search by name or email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          context.read<MeetingBloc>().add(SearchMembersEvent(value));
                        },
                      );
                    }
                  ),

                  BlocBuilder<MeetingBloc, MeetingState>(
                    buildWhen: (prev, curr) =>
                    curr is SearchMembersSuccess || curr is SearchMembersLoading,
                    builder: (context, state) {
                      if (state is SearchMembersLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }

                      if (state is SearchMembersSuccess) {
                        return Column(
                          children: state.users.map((member) {
                            return ListTile(
                              title: Text(member.user!.fullName!),
                              onTap: () {
                                  context.read<MeetingBloc>().add(AddParticipant(member));
                                  participantsController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                            );
                          }).toList(),
                        );
                      }

                      return const SizedBox();
                    },
                  ),


                  const SizedBox(height: 20),

                  BlocConsumer<MeetingBloc, MeetingState>(
                    listener: (context, state) {
                      if (state is AddMeetingSuccess) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is AddMeetingLoading) {
                        return Center(
                          child: Lottie.asset(Assets.jsonLoadingDots,
                              height: 150, width: 200),
                        );
                      } else if (state is AddMeetingFailure) {
                        return Text(
                          state.failure.message,
                          style: sataoshiRegular.copyWith(
                              fontSize: 13, color: Colors.redAccent),
                        );
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
                                log(getFinalDateTime().toString()) ;
                                context.read<MeetingBloc>().add(
                                  AddMeetingEvent(
                                    AddMeetingRequest(
                                      title: nameController.text,
                                      type: MeetingType.SCHEDULED,
                                      projectId: context.read<MeetingBloc>().projectBloc.projectModel!.id!,
                                      startDateTime: getFinalDateTime(),
                                      participantsIds: context.read<MeetingBloc>().selectedParticipants.map((member) => member.id!).toList(),
                                      duration: double.parse(durationController.text),
                                    ) ,
                                    context.read<MeetingBloc>().projectBloc.projectModel!.id!


                                  )
                                );

                              },
                              text: "Create Meeting",
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

// DATE PICKER
String? selectedDate;
pickProjectEndDate(BuildContext context, TextEditingController c) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    selectedDate = picked.toIso8601String();
    c.text =
    "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
  }
}
TimeOfDay? selectedTime;



String? getFinalDateTime() {
  if (selectedDate != null && selectedTime != null) {
    final combined = DateTime(
      DateTime
          .parse(selectedDate!)
          .year,
      DateTime
          .parse(selectedDate!)
          .month,
      DateTime
          .parse(selectedDate!)
          .day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    log(combined.toString()) ;
    return combined.toIso8601String().split('.')[0];
  }
  return null;
}