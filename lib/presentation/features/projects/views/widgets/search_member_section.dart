import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';

class SearchMemberSection extends StatelessWidget {
   SearchMemberSection({super.key});
 final TextEditingController searchController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          controller: searchController,
          hintText: "Search Members",
          prefixIcon: const Icon(Icons.search_outlined),
          onChanged: (value){
          },
        ) ,

      ],
    );
  }
}
