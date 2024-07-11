// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../components/my_theme.dart';
// import '../controllers/data_controller.dart';
// import '../models/data_model.dart';
//
// class HomeScreenUserList extends StatefulWidget {
//   const HomeScreenUserList({super.key});
//
//   @override
//   _HomeScreenUserListState createState() => _HomeScreenUserListState();
// }
//
// class _HomeScreenUserListState extends State<HomeScreenUserList> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       Provider.of<ViewModel>(context, listen: false).fetchData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//         actions: [
//           Consumer<ViewModel>(
//             builder: (context, viewModel, _) {
//               return IconButton(
//                 icon: Icon(viewModel.viewType == ViewType.list
//                     ? Icons.grid_view
//                     : Icons.list),
//                 onPressed: () => viewModel.toggleView(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Consumer<ViewModel>(
//         builder: (context, viewModel, _) {
//           if (viewModel.isLoading && viewModel.userList.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (viewModel.hasError) {
//             return const Center(child: Text("Error loading data"));
//           }
//           return Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//               MyTheme.cyan_with_light_sea_greens.withOpacity(0.2),
//               MyTheme.white,
//               MyTheme.white,
//               MyTheme.white,
//               MyTheme.white,
//               MyTheme.white,
//               MyTheme.cyan_with_light_sea_greens.withOpacity(0.2)
//             ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollInfo) {
//                 if (!viewModel.isLoading &&
//                     scrollInfo.metrics.pixels ==
//                         scrollInfo.metrics.maxScrollExtent) {
//                   viewModel.loadMoreData();
//                   return true;
//                 }
//                 return false;
//               },
//               child: viewModel.viewType == ViewType.list
//                   ? ListView.builder(
//                       itemCount: viewModel.userList.length,
//                       itemBuilder: (context, index) {
//                         User user = viewModel.userList[index];
//                         return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(05),
//                               color: Colors.white,
//                               border:
//                                   Border.all(color: Colors.grey), // Grey border
//                             ),
//                             child: ListTile(
//                               title: Text('${user.firstName} ${user.lastName}'),
//                               subtitle: Text('${user.email} ${user.phoneNo}'),
//                               trailing: ElevatedButton(
//                                 onPressed: () {},
//                                 child: const Text('View Profile'),
//                               ),
//                             ));
//                       },
//                     )
//                   : GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2),
//                       itemCount: viewModel.userList.length,
//                       itemBuilder: (context, index) {
//                         User user = viewModel.userList[index];
//                         return Padding(
//                           padding: const EdgeInsets.all(06.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(05),
//                               color: Colors.white,
//                               border:
//                                   Border.all(color: Colors.grey), // Grey border
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('${user.firstName} ${user.lastName}',
//                                       style: const TextStyle(
//                                           color: Colors.black87,
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.bold)),
//                                   const SizedBox(height: 2),
//                                   Text(user.email,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   Text(user.phoneNo,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   const Spacer(),
//                                   Center(
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         // Add functionality for view profile button
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.white,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(05.0),
//                                           side: BorderSide(
//                                               color: Colors.blue.shade400,
//                                               width: 0.8), // Black border
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'View Profile',
//                                         style: TextStyle(
//                                             color: Colors.blue.shade400),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           // Card(
//                           // color: Colors.white,
//                           //   shape: RoundedRectangleBorder(
//                           //     borderRadius: BorderRadius.circular(05.0),
//                           //     side: const BorderSide(color: Colors.grey, width: 1), // Black border
//                           //   ),
//                           // child: Padding(
//                           //   padding: const EdgeInsets.all(8.0),
//                           //   child: Column(
//                           //     crossAxisAlignment: CrossAxisAlignment.start,
//                           //     children: [
//                           //
//                           //
//                           //
//                           //
//                           //
//                           //       Text('${user.firstName} ${user.lastName}',
//                           //           style: const TextStyle(
//                           //             color: Colors.black87,
//                           //               fontSize: 11,
//                           //               fontWeight: FontWeight.bold)),
//                           //       const SizedBox(height: 2),
//                           //       Text(user.email,
//                           //           style: const TextStyle(
//                           //               fontWeight: FontWeight.bold)),
//                           //       Text(user.phoneNo,
//                           //           style: const TextStyle(
//                           //               fontWeight: FontWeight.bold)),
//                           //       const Spacer(),
//                           //       Center(
//                           //         child: ElevatedButton(
//                           //           onPressed: () {
//                           //             // Add functionality for view profile button
//                           //           },
//                           //           style: ElevatedButton.styleFrom(
//                           //             backgroundColor: Colors.white,
//                           //             shape: RoundedRectangleBorder(
//                           //               borderRadius: BorderRadius.circular(05.0),
//                           //               side:  BorderSide(color: Colors.blue.shade400, width: 0.8), // Black border
//                           //             ),
//                           //           ),
//                           //           child:  Text(
//                           //             'View Profile',
//                           //             style: TextStyle(color: Colors.blue.shade400),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           //                         ),
//                         );
//                       },
//                     ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_theme.dart';
import '../controllers/data_controller.dart';
import '../models/data_model.dart';

class HomeScreenUserList extends StatefulWidget {
  const HomeScreenUserList({super.key});

  @override
  _HomeScreenUserListState createState() => _HomeScreenUserListState();
}

class _HomeScreenUserListState extends State<HomeScreenUserList> {
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
        title: const Text('User List'),
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
              gradient: LinearGradient(
                colors: [
                  MyTheme.cyan_with_light_sea_greens.withOpacity(0.2),
                  MyTheme.white,
                  MyTheme.white,
                  MyTheme.white,
                  MyTheme.white,
                  MyTheme.white,
                  MyTheme.white,
                  MyTheme.cyan_with_light_sea_greens.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'User List',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(03),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                color: viewModel.viewType == ViewType.list
                                    ? Colors.blue.shade400
                                    : Colors.black,
                              ),
                              onPressed: () {
                                viewModel.setViewType(ViewType.list);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.grid_view,
                                color: viewModel.viewType == ViewType.grid
                                    ? Colors.blue.shade400
                                    : Colors.black,
                              ),
                              onPressed: () {
                                viewModel.setViewType(ViewType.grid);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                            physics: const BouncingScrollPhysics(),
                            itemCount: viewModel.userList.length,
                            itemBuilder: (context, index) {
                              User user = viewModel.userList[index];

                              return Padding(
                                padding: const EdgeInsets.all(04.0),
                                child: Container(
                                  // margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(05),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '${user.firstName} ${user.lastName}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.email,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          user.phoneNo,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 100, // Set the desired width here
                                      height: 28, // Set the desired height here
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Add functionality for view profile button
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: BorderSide(
                                              color: Colors.blue.shade400,
                                              width: 0.8,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'View Profile',
                                          style: TextStyle(
                                            color: Colors.blue.shade400,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: viewModel.userList.length,
                            itemBuilder: (context, index) {
                              User user = viewModel.userList[index];
                              return Padding(
                                padding: const EdgeInsets.all(06.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user.firstName} ${user.lastName}',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          user.email,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          user.phoneNo,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Center(
                                          child: SizedBox(
                                            width:
                                                120, // Set the desired width here
                                            height:
                                                28, // Set the desired height here
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Add functionality for view profile button
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                    color: Colors.blue.shade400,
                                                    width: 0.8,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                'View Profile',
                                                style: TextStyle(
                                                  color: Colors.blue.shade400,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
