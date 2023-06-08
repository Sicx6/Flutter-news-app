// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_news_/components/profile_container_title.dart';
import 'package:flutter_news_/screens/favourite_list_screen.dart';
import 'package:flutter_news_/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_textstyle.dart';

import '../Provider/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context, listen: false);

    void navigateUpdateProfile(BuildContext context) {
      Navigator.pushNamed(context, UpdateProfileScreen.routeName);
    }

    void navigateFavourite(BuildContext context) {
      Navigator.pushNamed(context, FavouritesListScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          child: Hero(
                            tag: '',
                            child: user.user?.photoURL == null
                                ? Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.contain,
                                  )
                                : ClipOval(
                                    child: Image.network(
                                      user.user?.photoURL as String,
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          user.user?.displayName ?? 'Guest',
                          style: AppTextStyle.abezee(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.grey[500],
                              size: 17,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              user.user?.phoneNumber ??
                                  'No information available',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Account',
                        style: AppTextStyle.abezee(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileContainerTitle(
                        onTap: () {
                          navigateUpdateProfile(context);
                        },
                        icon: Icons.person_2,
                        textTitle: 'Manage Profile',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileContainerTitle(
                          onTap: () {
                            navigateFavourite(context);
                          },
                          icon: Icons.bookmark,
                          textTitle: 'Favourite'),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Others',
                        style: AppTextStyle.abezee(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileContainerTitle(
                          onTap: () {},
                          icon: Icons.notifications_active,
                          textTitle: 'Notification'),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileContainerTitle(
                          onTap: () {
                            user.logOut(context);
                            print('log out');
                          },
                          icon: Icons.logout,
                          textTitle: 'Logout')
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
