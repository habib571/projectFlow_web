import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class MemberListTile extends StatelessWidget {
  const MemberListTile({
    super.key,
    required this.onTap,
    required this.name,
    required this.joinedAt,
    required this.role,
    this.imageUrl,
    required this.isLoading,
  });

  final String name;
  final String? joinedAt; // <-- nullable now
  final String role;
  final String? imageUrl;
  final bool isLoading;
  final VoidCallback onTap;

  DateTime? _parseJoinedDate() {
    if (isLoading) return null;
    if (joinedAt == null || joinedAt!.trim().isEmpty) return null;

    try {
      return DateFormat('dd-MM-yyyy').parse(joinedAt!);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final joinedDate = _parseJoinedDate();

    return Skeletonizer(
      enabled: isLoading,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isLoading ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePlaceHolderWeb(
                  radius: 24,
                  fullName: name,
                  imageUrl: imageUrl,
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: sataoshiBold.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role,
                        style: sataoshiMedium.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      if (joinedDate != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Joined ${DateFormat('MMM dd, yyyy').format(joinedDate)} · ${timeago.format(joinedDate)}",
                              style: sataoshiRegular.copyWith(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
