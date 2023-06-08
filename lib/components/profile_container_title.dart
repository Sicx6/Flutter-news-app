import 'package:flutter/material.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_textstyle.dart';

class ProfileContainerTitle extends StatelessWidget {
  final IconData icon;
  final String textTitle;
  final VoidCallback onTap;
  const ProfileContainerTitle({
    Key? key,
    required this.icon,
    required this.textTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.yellowGold,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(textTitle,
                style: AppTextStyle.abezee(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.paleGrey))
          ],
        ),
      ),
    );
  }
}
