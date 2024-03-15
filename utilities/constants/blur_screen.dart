import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';

typedef OnTap = void Function();
typedef OnVerticalDragUpdate = void Function(DragUpdateDetails);

class BlurWidget extends StatelessWidget {
  final bool isBlurred;
  final String? assetPath;
  final OnTap onTap;
  final OnVerticalDragUpdate onVerticalDragUpdate;
  final String? description;

  const BlurWidget({
    Key? key,
    required this.isBlurred,
    required this.onTap,
    this.assetPath,
    required this.onVerticalDragUpdate, this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isBlurred)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
        // Add your Lottie animation here

        if (isBlurred)
          GestureDetector(
            onTap: onTap,
            onVerticalDragUpdate:  onVerticalDragUpdate,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    assetPath ?? AssetPath.image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 150),
                  Text( description ?? "Swipe Up for more flash cards",style: Theme.of(context).textTheme.titleMedium,)
                ],
              ),
            ),
          ),
      ],
    );
  }
}
