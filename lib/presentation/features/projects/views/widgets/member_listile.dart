import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class MemberListTile extends StatelessWidget {
  const MemberListTile({super.key, required this.member, required this.onTap});
final MemberModel member ;
final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
       trailing: ImagePlaceHolderWeb(radius: 25, fullName: member.user!.fullName!, imageUrl: member.user!.imageUrl),
        title: Text(
          member.user!.fullName!,
          style: sataoshiBold.copyWith(fontSize: 16)
        ),
       subtitle: Text(
           member.role!,
           style: sataoshiMedium.copyWith(fontSize: 14)
       ),
       leading: Text(
         member.joinedAt!,
         style: sataoshiRegular.copyWith(fontSize: 15)
       ),
    ) ;
  }
}
