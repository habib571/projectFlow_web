import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class SelectMemberWidget extends StatefulWidget {
   const SelectMemberWidget({super.key, required this.members});
  final List<MemberModel> members ;

  @override
  State<SelectMemberWidget> createState() => _SelectMemberWidgetState();
}

class _SelectMemberWidgetState extends State<SelectMemberWidget> {
   MemberModel? selectedMember  ;
  @override
  Widget build(BuildContext context) {
    return   DropdownButton<MemberModel>(
      hint: const Text('Select user'),
      value: selectedMember,
      icon: const Icon(Icons.arrow_drop_down),
      items: widget.members.map((user) {
        return DropdownMenuItem<MemberModel>(
          value: user,
          child: Row(
            children: [
            ImagePlaceHolderWeb(radius: 15, fullName: user.user!.fullName!) ,
              const SizedBox(width: 8),
              Text(user.user!.fullName! ,style: sataoshiRegular.copyWith(fontSize: 14,)),
            ],
          ),
        );
      }).toList(),
      onChanged: (MemberModel? newUser) {
        setState(() {
          selectedMember = newUser;
        });
      },
      selectedItemBuilder: (context) {
          return widget.members.map((user) {
          return Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                user.user!.fullName!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }).toList();
      },
    );

  }
}
