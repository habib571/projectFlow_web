import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;
class MemberListTile extends StatelessWidget {
  const MemberListTile({super.key,required this.onTap, required this.name, required this.joinedAt, required this.role, this.imageUrl, required this.isLoading});
final String name ;
final String joinedAt;
final String role ;
final String? imageUrl ;
final bool isLoading ;
final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        onTap: () {
          onTap();
        },
         leading: ImagePlaceHolderWeb(radius: 25, fullName: name, imageUrl: imageUrl),
          title: Text(
            name,
            style: sataoshiBold.copyWith(fontSize: 16)
          ),
         subtitle: Text(
             role ,
             style: sataoshiMedium.copyWith(fontSize: 14)
         ),
         trailing: Text(
             "Joined $joinedAt(${timeago.format(DateFormat('dd-MM-yyyy').parse(joinedAt))})",
           style: sataoshiRegular.copyWith(fontSize: 15)
         ),
      ),
    ) ;
  }
}
