import 'package:flutter/material.dart';
import 'constants.dart';

class ItemWidget extends StatelessWidget {
  final bool selected;
  final List<String> imageName;
  const ItemWidget({Key? key, required this.selected, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundColor:
                    selected ? kTextColor.withOpacity(0.5) : Colors.transparent,
                child: Image.asset(
                  imageName.join('/') + '.png',
                  scale: 0.7,
                ),
              ),
            ),
            Text(
              imageName.last,
              textAlign: TextAlign.center,
            )
          ],
        ),
        selected
            ? const Positioned(
                top: 0,
                right: 10,
                child: Icon(
                  Icons.verified,
                  color: Colors.green,
                ))
            : const IgnorePointer()
      ],
    );
  }
}
