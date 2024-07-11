// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// class EcoBlueSubAdmin extends StatefulWidget {
//   const EcoBlueSubAdmin({super.key});
//
//   @override
//   State<EcoBlueSubAdmin> createState() => _EcoBlueSubAdminState();
// }
//
// class _EcoBlueSubAdminState extends State<EcoBlueSubAdmin> {
//   bool isButtonSelected = false;
//
//
//   String formatDate(String dateString) {
//     DateTime dateTime = DateTime.parse(dateString);
//     String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
//     return formattedDate;
//   }
//   @override
//   void initState() {
//     ecoBlueSubAdminController = EcoBlueSubAdminController(context: context);
//     // TODO: implement initState
//     super.initState();
//     _scrollController.addListener(
//             (){
//           _onScroll();
//         }
//     );
//   }
//
//   late EcoBlueSubAdminController ecoBlueSubAdminController ;
//
//   TextEditingController _searchController = TextEditingController();
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       _fetchData();
//     }
//   }
//
//   Future<void> _fetchData() async {
//     int currentDataLength = ecoBlueSubAdminController.ecoModel?.data.length??0;
//
//     if (!isLoadingMoreData && ecoBlueSubAdminController.ecoModel?.data.length != ecoBlueSubAdminController.ecoModel?.pagination?.totalItems ) {
//       int limit = currentDataLength + 10;
//       setState(() {
//         isLoadingMoreData = true;
//       });
//       await Future.delayed(Duration(seconds: 1));
//       debugPrint(limit.toString());
//       ecoBlueSubAdminController.getEcoBlueSubAdminApi(context, "1", '$limit',_searchController.text).then(
//               (value){
//             debugPrint(ecoBlueSubAdminController.ecoModel?.data.length.toString());
//             setState(() {
//               isLoadingMoreData =false;
//             });
//           });
//       // dataList.addAll(List.generate(10, (index) => index + dataList.length));
//       // currentPage++;
//       // isLoading1 = false;
//
//     }
//   }
//   ScrollController _scrollController = ScrollController();
//
//   bool isLoadingMoreData = false;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: (){
//         return Future((){
//           Navigator.pushNamed(context,AppScreen.dashboard);
//           return false;
//         });
//       },
//       child: GetBuilder(
//           init: ecoBlueSubAdminController,
//           builder: (controller) => Scaffold(
//               floatingActionButton: FloatingActionButton(
//                 backgroundColor: AppColor.green,
//                 onPressed: () {
//                   Navigator.pushNamed(context, AppScreen.ecoBlueSubAdminAddScreen,
//                   );
//                 },
//                 child: const Icon(Icons.add),
//               ),
//               body:Container(
//                   padding: EdgeInsets.only(left: 15, right: 15),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Flexible(
//                             child: CustomSearchTextField(
//                               controller: _searchController,
//                               onChanged: (value) {
//                                 ecoBlueSubAdminController.getEcoBlueSubAdminApi(context, '1', '10', value).then((value){
//                                   setState(() {});
//                                 });
//                                 // if(value.length>=3){
//                                 //   ecoBlueSubAdminController.getEcoBlueSubAdminApi(context, '1', '10', value);
//                                 // }else{
//                                 //   ecoBlueSubAdminController.getEcoBlueSubAdminApi(context, '1', '10', value);
//                                 // }
//                                 // filterSearchResults(value); // Call the filter method when text changes
//                               },
//                               hintText: 'Search  here...',
//                               hintStyle: TextStyle(
//                                   fontSize: 12,
//                                   color: AppColor.grey1.withOpacity(0.5)),
//                               suffixIcon: Icon(
//                                 Icons.search,
//                                 color: AppColor.green,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           // GestureDetector(
//                           //   onTap: () {
//                           //     showModalBottomSheet(
//                           //       context: context,
//                           //       shape: const RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.vertical(
//                           //           top: Radius.circular(25.0),
//                           //         ),
//                           //       ),
//                           //       backgroundColor: Colors.white,
//                           //       builder: (BuildContext context) {
//                           //         return Wrap(
//                           //           children: [
//                           //             Column(
//                           //               mainAxisAlignment:
//                           //                   MainAxisAlignment.spaceBetween,
//                           //               crossAxisAlignment:
//                           //                   CrossAxisAlignment.start,
//                           //               children: [
//                           //                 Column(
//                           //                   crossAxisAlignment:
//                           //                       CrossAxisAlignment.start,
//                           //                   children: [
//                           //                     Padding(
//                           //                       padding:
//                           //                           const EdgeInsets.all(20.0),
//                           //                       child: Row(
//                           //                         children: [
//                           //                           SvgPicture.asset(
//                           //                             AppImages.union,
//                           //                             height: 15,
//                           //                           ),
//                           //                           const SizedBox(
//                           //                             width: 10,
//                           //                           ),
//                           //                           const Text(
//                           //                             "Filter By",
//                           //                             style: TextStyle(
//                           //                                 fontFamily: AppFont
//                           //                                     .poppinsSemiBold),
//                           //                           )
//                           //                         ],
//                           //                       ),
//                           //                     ),
//                           //                     Padding(
//                           //                       padding: const EdgeInsets.only(
//                           //                           left: 20,
//                           //                           right: 20,
//                           //                           top: 10,
//                           //                           bottom: 10),
//                           //                       child: Row(
//                           //                         mainAxisAlignment:
//                           //                             MainAxisAlignment
//                           //                                 .spaceBetween,
//                           //                         children: [
//                           //                           Text('Name'),
//                           //                           const SizedBox(
//                           //                             width: 10,
//                           //                           ),
//                           //                           CustomRadioButton(
//                           //                             isSelected:
//                           //                                 isButtonSelected,
//                           //                             onChanged: (value) {
//                           //                               setState(() {
//                           //                                 isButtonSelected =
//                           //                                     value;
//                           //                               });
//                           //                             },
//                           //                           )
//                           //                         ],
//                           //                       ),
//                           //                     ),
//                           //                     Divider(
//                           //                       color: Colors.black
//                           //                           .withOpacity(0.59),
//                           //                     ),
//                           //                     Padding(
//                           //                       padding: const EdgeInsets.only(
//                           //                           left: 20,
//                           //                           right: 20,
//                           //                           top: 10,
//                           //                           bottom: 10),
//                           //                       child: Row(
//                           //                         mainAxisAlignment:
//                           //                             MainAxisAlignment
//                           //                                 .spaceBetween,
//                           //                         children: [
//                           //                           Text('Email'),
//                           //                           const SizedBox(
//                           //                             width: 10,
//                           //                           ),
//                           //                           CustomRadioButton(
//                           //                             isSelected:
//                           //                                 isButtonSelected,
//                           //                             onChanged: (value) {
//                           //                               setState(() {
//                           //                                 isButtonSelected =
//                           //                                     value;
//                           //                               });
//                           //                             },
//                           //                           )
//                           //                         ],
//                           //                       ),
//                           //                     ),
//                           //                     Divider(
//                           //                       color: Colors.black
//                           //                           .withOpacity(0.59),
//                           //                     ),
//                           //                     Padding(
//                           //                       padding: const EdgeInsets.only(
//                           //                           left: 20,
//                           //                           right: 20,
//                           //                           top: 10,
//                           //                           bottom: 10),
//                           //                       child: Row(
//                           //                         mainAxisAlignment:
//                           //                             MainAxisAlignment
//                           //                                 .spaceBetween,
//                           //                         children: [
//                           //                           Text('Date Added'),
//                           //                           const SizedBox(
//                           //                             width: 10,
//                           //                           ),
//                           //                           CustomRadioButton(
//                           //                             isSelected:
//                           //                                 isButtonSelected,
//                           //                             onChanged: (value) {
//                           //                               setState(() {
//                           //                                 isButtonSelected =
//                           //                                     value;
//                           //                               });
//                           //                             },
//                           //                           )
//                           //                         ],
//                           //                       ),
//                           //                     ),
//                           //                     const SizedBox(
//                           //                       height: 10,
//                           //                     ),
//                           //                   ],
//                           //                 )
//                           //               ],
//                           //             ),
//                           //           ],
//                           //         );
//                           //       },
//                           //     );
//                           //   },
//                           //   child: Container(
//                           //       padding: EdgeInsets.all(6),
//                           //       decoration: BoxDecoration(
//                           //         color: Colors.white,
//                           //         border: Border.all(color: AppColor.green),
//                           //         borderRadius: BorderRadius.circular(7),
//                           //       ),
//                           //       child: Icon(
//                           //         Icons.filter_alt_outlined,
//                           //         color: AppColor.green,
//                           //       )),
//                           // )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Expanded(
//                         child: ScrollConfiguration(
//                           behavior: MyBehavior(),
//                           child: controller.ecoModel?.data == null ? myShimmer() :controller.ecoModel?.data.length == 0? Center(child: Text("No eco blue sub admin List found !!"))
//                               : ListView.builder(
//                             controller: _scrollController,
//                             itemCount:ecoBlueSubAdminController.ecoModel?.data.length?? 0,
//                             itemBuilder: (context, index) {
//                               // debugPrint("dataaaa length  ${controller.ecoModel?.data.length}");
//                               // if(index == controller.ecoModel!.data.length){
//                               //   return Center(child: CircularProgressIndicator(color:AppColor.green));
//                               // }
//                               // else{
//                               // _fetchData(controller);
//                               var ecoBlueSubAdmin = ecoBlueSubAdminController.ecoModel?.data[index];
//                               String apiDateString = "${ecoBlueSubAdminController.ecoModel?.data[index].createdAt}";
//                               String formattedDate = formatDate(apiDateString);
//                               return Obx(
//                                     () {
//                                   return Column(
//                                     children: [
//                                       Stack(
//                                         clipBehavior: Clip.none,
//                                         children: [
//                                           Container(
//                                             padding: EdgeInsets.only(
//                                               top: 15,
//                                             ),
//                                             margin: const EdgeInsets.only(
//                                                 bottom: 5),
//                                             child: Card(
//                                               elevation: 1,
//                                               margin: EdgeInsets.zero,
//                                               shape: ContinuousRectangleBorder(
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       20)),
//                                               clipBehavior: Clip.hardEdge,
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsets.all(15.0),
//                                                 child: Column(
//                                                   children: [
//                                                     SizedBox(
//                                                       height: 7,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                       children: [
//                                                         Expanded(
//                                                           child: const Text(
//                                                             "Name",
//                                                             style: TextStyle(
//                                                                 color: AppColor
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily: AppFont
//                                                                     .poppinsLight),
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           flex: 1,
//                                                           child: Text(
//                                                             "${ecoBlueSubAdmin?.firstName}",
//                                                             style: TextStyle(
//                                                                 color: AppColor
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily: AppFont
//                                                                     .poppinsLight),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Divider(
//                                                       color: AppColor.black,
//                                                     ),
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                       children: [
//                                                         Expanded(
//                                                           child: const Text(
//                                                             "Email",
//                                                             style: TextStyle(
//                                                                 color: AppColor
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily: AppFont
//                                                                     .poppinsLight),
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           flex: 1,
//                                                           child: Text(
//                                                             "${ecoBlueSubAdmin?.email}",
//                                                             style: TextStyle(
//                                                                 color: AppColor
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily: AppFont
//                                                                     .poppinsLight),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Divider(
//                                                       color: AppColor.black,
//                                                     ),
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                       children: [
//                                                         Expanded(
//                                                           child: const Text(
//                                                             "Date Added",
//                                                             style: TextStyle(
//                                                                 color: AppColor
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily: AppFont
//                                                                     .poppinsLight),
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                             flex: 1,
//                                                             child: Text(
//                                                               "${formattedDate}",
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 13,
//                                                                 fontFamily:
//                                                                 'PoppinsLight',
//                                                               ),
//                                                             )),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                       height: 7,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: MediaQuery.of(context)
//                                                 .size
//                                                 .width *
//                                                 0.8,
//                                             top: -8,
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 ecoBlueSubAdminController.subAdminVisibilityController.toggleVisibility(index);
//                                               },
//                                               child: Image.asset(
//                                                 AppImages.opestion,
//                                                 height: 50,
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 199,
//                                             top: -8,
//                                             child: Visibility(
//                                               visible:
//                                               ecoBlueSubAdminController.subAdminVisibilityController
//                                                   .areOptionVisibleList[
//                                               index],
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>EcoBlueSubAdminDetails(subAdminList: ecoBlueSubAdmin,)));
//                                                 },
//                                                 child: Container(
//                                                   child: Image.asset(
//                                                     AppImages.eye,
//                                                     height: 50,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 232,
//                                             top: -8,
//                                             child: Visibility(
//                                               visible:
//                                               ecoBlueSubAdminController.subAdminVisibilityController
//                                                   .areOptionVisibleList[
//                                               index],
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) => EcoBlueSubAdminEditScreen(model: controller.ecoModel, index: index,
//                                                       ),
//                                                     ),
//                                                   ).then((value){controller.getEcoBlueSubAdminApi(context, "1", "10", "");});
//
//
//                                                 },
//                                                 child: Container(
//                                                   child: Image.asset(
//                                                     AppImages.edit,
//                                                     height: 50,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             left: 265,
//                                             top: -10,
//                                             child: Visibility(
//                                               visible:
//                                               ecoBlueSubAdminController.subAdminVisibilityController
//                                                   .areOptionVisibleList[
//                                               index],
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   showDialog(
//                                                     context: context,
//                                                     builder:
//                                                         (BuildContext context) {
//                                                       return CupertinoAlertDialog(
//                                                         title: Column(
//                                                           children: [
//                                                             Text(
//                                                               "Are you sure you want to Delete this User?",
//                                                               style: TextStyle(
//                                                                   fontSize: 15,
//                                                                   color: AppColor
//                                                                       .black),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 10,
//                                                             ),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceAround,
//                                                               children: [
//                                                                 GestureDetector(
//                                                                   onTap: () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   },
//                                                                   child:
//                                                                   Container(
//                                                                     padding:
//                                                                     EdgeInsets
//                                                                         .all(9),
//                                                                     decoration:
//                                                                     BoxDecoration(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(
//                                                                           7),
//                                                                       color: AppColor
//                                                                           .green,
//                                                                     ),
//                                                                     child: Text(
//                                                                       'Cancel',
//                                                                       style: TextStyle(
//                                                                           fontFamily: AppFont
//                                                                               .poppinsLight,
//                                                                           fontSize:
//                                                                           15,
//                                                                           color:
//                                                                           Colors.white),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 GestureDetector(
//                                                                   onTap: () {
//                                                                     controller.deleteEcoBlueSubAdminApi(ecoBlueSubAdmin!.id.toString());
//                                                                     Navigator.pop(context);
//                                                                   },
//                                                                   child:
//                                                                   Container(
//                                                                     padding: EdgeInsets.only(
//                                                                         left:
//                                                                         20,
//                                                                         right:
//                                                                         20,
//                                                                         bottom:
//                                                                         10,
//                                                                         top:
//                                                                         10),
//                                                                     decoration:
//                                                                     BoxDecoration(
//                                                                       borderRadius:
//                                                                       BorderRadius.circular(
//                                                                           7),
//                                                                       color: AppColor
//                                                                           .green,
//                                                                     ),
//                                                                     child:
//                                                                     Center(
//                                                                       child:
//                                                                       Text(
//                                                                         'yes',
//                                                                         style: TextStyle(
//                                                                             fontFamily: AppFont
//                                                                                 .poppinsLight,
//                                                                             fontSize:
//                                                                             15,
//                                                                             color:
//                                                                             Colors.white),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ), // show pop-up
//                                                       );
//                                                     },
//                                                   );
//                                                 },
//                                                 child: Container(
//                                                   child: Image.asset(
//                                                     AppImages.delete,
//                                                     height: 50,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       if(index == (ecoBlueSubAdminController.ecoModel?.data.length??0)-1  && isLoadingMoreData && (ecoBlueSubAdminController.ecoModel?.data.length != ecoBlueSubAdminController.ecoModel?.pagination?.totalItems))
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: CircularProgressIndicator(color:AppColor.green),
//                                         )
//                                     ],
//                                   );
//                                 },
//                               );
//                               // }
//
//                             },
//
//                           ),
//                         ),
//                       )
//                     ],
//                   )))),
//     );
//   }
// }
//
//
// // ignore: must_be_immutable
