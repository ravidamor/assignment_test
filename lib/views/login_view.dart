import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/my_theme.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(top: 120),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                MyTheme.cyan_with_light_sea_greens.withOpacity(0.2),
                MyTheme.white,
                MyTheme.white,
                MyTheme.white,
                MyTheme.white,
                MyTheme.white,
                MyTheme.cyan_with_light_sea_greens.withOpacity(0.2)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.blue,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(left: 0.0),
                            tabs: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Tab(text: 'Sign in'),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Tab(text: 'Sign up'),
                              ),
                            ],
                          ),
                        ),
                        const Flexible(child: SizedBox())
                      ],
                    ),
                    Flexible(
                      child: TabBarView(
                        children: [
                          const SignInForm(),
                          SignUpForm(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
