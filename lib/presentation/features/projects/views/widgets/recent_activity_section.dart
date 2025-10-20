import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/recent_activity_card.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Card(
          elevation: 1,
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Activity", style: sataoshiBold.copyWith(fontSize: 18)) ,
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) => const RecentActivityCard(),
                    itemCount: 5,
                    shrinkWrap: true,
                  )),
                ],
              ))),
    );
  }
}
