import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class ProjectDetailsHeader extends StatelessWidget {
  const ProjectDetailsHeader({super.key, required this.isManager, required this.title, required this.onDelete, required this.onEdit});
 final bool  isManager ;
 final String title ;
 final Function() onDelete ;
 final Function() onEdit ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
               context.go('/projects');
            }, icon: const Icon(Icons.arrow_back)) ,
             Text("Back to Projects" ,style: sataoshiMedium.copyWith(fontSize: 16 ,color: AppColors.secondaryGrey))
          ],
        ),
        const SizedBox(height: 30,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: sataoshiBold.copyWith(fontSize: 18),
            ),
            Row(
              children: [
                isManager ? _editButton() : const SizedBox.shrink() ,
                const SizedBox(width: 10,) ,
                isManager ? _deleteButton() : const SizedBox.shrink() ,
                const SizedBox(width: 10,) ,
                _kanbanButton()

              ],

            )
            ]

        )


      ],
    );
  }
  Widget _deleteButton() {
    return SizedBox(
      width: 100,
      child: CustomButton(
        trailing: Image.asset(Assets.iconsDelete ,color: Colors.redAccent),
        buttonColor: Colors.white,
        enableBorderSide: true,
        borderSideColor: Colors.redAccent,
        onPressed: () {
          onDelete();
        },
        text: "Delete",
        textStyle: sataoshiMedium.copyWith(color: Colors.redAccent),
      ),
    );

  }
  Widget _editButton() {
    return SizedBox(
      width: 100,
      child: CustomButton(
        trailing: Image.asset(Assets.iconsEdit ,color: AppColors.primary500),
        buttonColor: Colors.white,
        enableBorderSide: true,
        borderSideColor: AppColors.primary500,
        onPressed: () {
          onEdit();
        },
        text: "Edit",
        textStyle: sataoshiMedium.copyWith(color: AppColors.primary500),
      ),
    );

  }

  Widget _kanbanButton() {
    return
    SizedBox(
      width: 170,
      child: CustomButton(
        trailing: Image.asset(
          Assets.iconsKanban,
          color: Colors.white,
          height: 30,
        ),
        buttonColor: AppColors.primary500,
        onPressed: () {
         // context.go('/projects/details');
        },
        text: "Kanban Board",
        textStyle: sataoshiMedium.copyWith(color: Colors.white),
      ),
    ) ;
  }

}
