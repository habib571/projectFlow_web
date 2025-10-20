import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/constants/endpoints.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';


class ImagePlaceHolderWeb extends StatelessWidget {
  final double radius;
  final String? imageUrl;       // network URL
  final Uint8List? imageBytes;  // uploaded file
  final bool imgBorder;
  final String fullName;
  final LocalStorage _localStorage = getIt<LocalStorage>() ;
  ImagePlaceHolderWeb({
    super.key,
    required this.radius,
    this.imageUrl,
    this.imageBytes,
    this.imgBorder = false,
    required this.fullName,
  }) ;

  @override
  Widget build(BuildContext context) {
    final String letter = (fullName.isNotEmpty && fullName != "Loading..."
        ? fullName[0]
        : "?").toUpperCase();

    if (imageBytes != null) {
      return _buildFromBytes();
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return _buildNetworkImage(letter);
    } else {
      return _buildInitials(letter);
    }
  }

  Widget _buildFromBytes() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: imgBorder ? Border.all(color: AppColors.primary400, width: 1) : null,
        image: DecorationImage(
          image: MemoryImage(imageBytes!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNetworkImage(String letter) {
    return FutureBuilder(
        future: _localStorage.load(key: "token" ,boxName: "userData") ,
      builder: (context ,snapshot) {
        return CachedNetworkImage(
          httpHeaders: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${snapshot.data}'
          },
          imageUrl: imageUrl!.startsWith('http')
              ? imageUrl!
              : "${Endpoints.baseUrl}/images/$imageUrl",
          imageBuilder: (context, imageProvider) => Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: imgBorder ? Border.all(color: AppColors.primary400, width: 1) : null,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => SizedBox(
            width: radius,
            height: radius,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => _buildInitials(letter),
        );
      }
    );
  }

  Widget _buildInitials(String letter) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: _getColorFromFirstLetter(letter),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: radius * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getColorFromFirstLetter(String letter) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.indigo,
      Colors.teal,
      Colors.brown,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.cyan,
      Colors.pink,
      Colors.amber,
    ];
    int index = letter.codeUnitAt(0) % colors.length;
    return colors[index];
  }
}
