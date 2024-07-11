// import 'package:fluitter_machine_test/views/splash_scren.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'views/login_view.dart';
// import 'views/home_view.dart';
// import 'controllers/login_controller.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoginController()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false, // This removes the debug banner
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => SplashScreen(),
//           '/login': (context) => const LoginView(),
//           '/home': (context) => const HomeScreenUserList(),
//         },
//       ),
//     );
//   }
// }

import 'package:fluitter_machine_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/my_theme.dart';
import 'controllers/data_controller.dart';
import 'models/data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataController dataController = DataController(
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWMxZjk4ZjE0MTg5YmYzYjAwMWY0ZjZlYzlhODU3YWJiN2ZkODllYjRlZGJhNzhjNDNiNGNkOTdlODZhMWUzMmJhMjdiYmVlZGQyMmI1YjMiLCJpYXQiOjE3MjA2Nzc3MDEuNzQ5NjYzLCJuYmYiOjE3MjA2Nzc3MDEuNzQ5NjcyLCJleHAiOjE3NTIyMTM3MDEuNzM2MjY2LCJzdWIiOiI1MiIsInNjb3BlcyI6W119.j51BXsItmY0xY_giIAFwXolWDbabrwofY9Vs24r-Y3rPFhi3CsvvGaEZBD1yPBfYoTKXbspQ9zT7YOfX1OwKuS3eCFeWjlx2J5Y0914xHU6MvlhDZd3mIMHu7rodgUXmKLBdC2Hqiem-8H3PA5w7Xjv7TVdsybZq9utldCCgd3oIz-7dp0Zrp6AZk0VQPqjZEXcGq6iEm7qPwmgbZ0oHuEY0XwfgH90GC5OYM2EdNEcbM9zwc94qHEP1uFFxDx4kEQt5njsT4XfTloiI6jf7E5Fz947CXyofToFvjRhGA5Or8jQ0ZK43UFNU0vqsw6lholUBcjolyuotS-w-l3prr_Wa5dn76eTOtWMumqYtrpdM1t3VyESK7IUjTwv_Vej9p6xi6Z4ZxYj7BmEFXMTAoEoTlw8__k9CUtrlixQhPz480zpUErw8vxd4ZILjhvQY3zHlL8rjZxkIBJDJoU6FPOWzGgOrGbtWr2BRObGy911v1sBksAmd1-2EB2bdhPhF0CWPyeVoKIEMMrNzPwEMBnNmkRLRS93Ui3kb2EEWOHCjmMppp-Q-aLSwVn0Y_X7brND87YUVFrEBr5YJDmXYdnfYdS7TsXiVQOFi2AmHKERDlbhx43uresO1uA9y1tWNrZ9TeswO1tmMY0aISMVQKRg7JfYPZNHVR35wDfa25RE'); // Instantiate DataController

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewModel(dataController)),
      ],
      child: const MaterialApp(

        home: HomeScreenUserList(),
      ),
    );
  }
}

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ViewModel>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          Consumer<ViewModel>(
            builder: (context, viewModel, _) {
              return IconButton(
                icon: Icon(viewModel.viewType == ViewType.list
                    ? Icons.grid_view
                    : Icons.list),
                onPressed: () => viewModel.toggleView(),
              );
            },
          ),
        ],
      ),
      body: Consumer<ViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading && viewModel.userList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.hasError) {
            return const Center(child: Text("Error loading data"));
          }
          return Container(
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
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!viewModel.isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  viewModel.loadMoreData();
                  return true;
                }
                return false;
              },
              child: viewModel.viewType == ViewType.list
                  ? ListView.builder(
                      itemCount: viewModel.userList.length,
                      itemBuilder: (context, index) {
                        User user = viewModel.userList[index];
                        return ListTile(
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text('${user.email} ${user.phoneNo}'),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text('View Profile'),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: viewModel.userList.length,
                      itemBuilder: (context, index) {
                        User user = viewModel.userList[index];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(05.0),
                              side: const BorderSide(color: Colors.grey, width: 1), // Black border
                            ),
                          //  color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(02.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('Email: ${user.email}'),
                                  Text('Phone: ${user.phoneNo}'),
                                  const Spacer(),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Add functionality for view profile button
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(05.0),
                                          side:  BorderSide(color: Colors.blue.shade400, width: 0.8), // Black border
                                        ),
                                      ),
                                      child:  Text(
                                        'View Profile',
                                        style: TextStyle(color: Colors.blue.shade400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                        // return Card(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text('${user.firstName} ${user.lastName}',
                        //             style: const TextStyle(
                        //                 fontWeight: FontWeight.bold)),
                        //         const SizedBox(height: 5),
                        //         Text('Email: ${user.email}'),
                        //         Text('Phone: ${user.phoneNo}'),
                        //         const Spacer(),
                        //         ElevatedButton(
                        //           onPressed: () {},
                        //           child: const Text('View Profile'),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
