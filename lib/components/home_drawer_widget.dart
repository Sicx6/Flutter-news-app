import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/theme_provider.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/screens/favourite_list_screen.dart';
import 'package:flutter_news_/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
    required this.theme,
  });

  final ThemeChanger theme;

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    void navigateProfileScreen(BuildContext context) {
      Navigator.pushNamed(context, ProfileScreen.routeName);
    }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.softLight,
                // image: DecorationImage(
                //     image: AssetImage('assets/images/back.jpg'),
                //     fit: BoxFit.fitWidth),
                color: AppColor.lightPurple),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateProfileScreen(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Hero(
                      tag: '',
                      child: appUser.user?.photoURL == null
                          ? Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.contain,
                            )
                          : ClipOval(
                              child: Image.network(
                                appUser.user?.photoURL as String,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Welcome the My News Apps'),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode'),
                    Switch(
                      value: theme.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        Provider.of<ThemeChanger>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => navigateProfileScreen(context),
                child: ListTile(
                  title: const Text('Profile'),
                  leading: Icon(
                    Icons.person,
                    color: AppColor.yellowGold,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Change Password'),
                leading: Icon(
                  Icons.password,
                  color: AppColor.yellowGold,
                ),
              ),
              ListTile(
                title: const Text('Favourite Articles'),
                leading: Icon(
                  Icons.newspaper,
                  color: AppColor.yellowGold,
                ),
                onTap: () {
                  Navigator.pushNamed(context, FavouritesListScreen.routeName);
                },
              ),
              ListTile(
                title: const Text('Log Out'),
                leading: Icon(
                  Icons.logout_rounded,
                  color: AppColor.yellowGold,
                ),
                onTap: () {
                  AppUser().logOut(context);
                },
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       child: Row(
              //         children: [
              //           Row(
              //             children: [
              //               IconButton(
              //                 onPressed: () {
              //                   Provider.of<ThemeChanger>(context,
              //                           listen: false)
              //                       .toggleTheme();
              //                 },
              //                 icon: Icon(
              //                   theme.themeMode == ThemeMode.light
              //                       ? Icons.dark_mode
              //                       : Icons.light_mode,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
