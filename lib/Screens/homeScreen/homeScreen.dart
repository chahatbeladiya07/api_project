// ignore_for_file: use_build_context_synchronously

import 'package:api_project/color_consts.dart';
import 'package:api_project/api/api_call.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../widgets/icon_title.dart';
import '../../widgets/customButton.dart';
import '../createUser/create_user_screen.dart';

class HomeScreen extends StatefulWidget {
  static const pageName="/home";

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<UserModel> services = [];
  final buttonList=const [
    {
      "title" : "EDIT",
      "svgPath" : "assets/icons/edit2.svg"
    },
    {
      "title" : "DELETE",
      "svgPath" : "assets/icons/delete.svg"
    }
  ];
  List<int> selectedId = [];
  int length=0;
  bool islongpress=false;
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context.read<ApiProvideClass>().apiCall();
     //     .then((value) {
     //   if(value.success && value.data!=null){
     //     services=value.data;
     //   }
     //   tempList=List.filled(services.length, false);
     // });

   });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider=context.watch<ApiProvideClass>();
    final users=context.watch<ApiProvideClass>().users;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child:provider.isLoadingForDelete==true?
                  const SizedBox(
              height: 25,
                width: 25.0,
                child: CircularProgressIndicator(color: Colors.white,))
                : InkWell(
              onTap: () async {
                if(selectedId.isNotEmpty){
                  for(int i=0; i<selectedId.length; i++) {
                    final isdeleted = await context.read<ApiProvideClass>().apiDelete(id: selectedId.elementAt(i));
                    if(isdeleted.success==true){
                      users.removeWhere((element) => element.id==selectedId[i]);
                    }
                  }
                  // context.read<apiProvideClass>().apiCall();
                  context.read<ApiProvideClass>().tempList=List.filled(users.length, false);
                  selectedId.clear();
                  islongpress=false;
                } else {
                  Fluttertoast.showToast(msg: "Please select items to delete");
                }
              },
                child: Icon(Icons.delete,color: selectedId.isNotEmpty?Colors.white: Colors.black26,))
          ),


        ],
      ),
      body: provider.isloading==true ?
      const Center(child: CircularProgressIndicator()): buildUi() ,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
           Navigator.pushNamed(context, CreateUserScreen.pageName);
           //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2(),));
           // setState(() {});
          },
          elevation: 0,
          backgroundColor: appPrimary.withOpacity(0.7),
          label: const Text("Add",style: TextStyle(color: Colors.white),),
          icon: const Icon(Icons.add,color: Colors.white,),),
    );
  }
  Padding buildUi() {
    final users= context.watch<ApiProvideClass>().users;
    final tempList=context.watch<ApiProvideClass>().tempList;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<ApiProvideClass>().apiCall();
        },
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user=users.elementAt(index);
            return Stack(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onLongPress: () {
                    islongpress=true;
                    if(islongpress=true){
                      if(tempList[index]==false){
                        tempList[index]=true;
                      } else {
                        tempList[index]=false;
                      }
                      if(selectedId.contains(user.id)){
                        selectedId.removeAt(selectedId.indexOf(user.id));
                      } else {
                        selectedId.add(user.id);
                      }
                      // print("selected Index : $index => ${selectedId.elementAt(index)}");
                      if(selectedId.isEmpty){
                        islongpress=false;
                      }
                    }
                    setState(() {});
                  },
                  onTap: (){
                    if(islongpress==true){
                      if(tempList[index]==false){
                        tempList[index]=true;
                      } else {
                        tempList[index]=false;
                      }
                      if(selectedId.contains(user.id)){
                        selectedId.removeAt(selectedId.indexOf(user.id));
                      } else {
                        selectedId.add(user.id);
                      }
                      // print("selected Index : $index => ${selectedId.elementAt(index)}");
                      if(selectedId.isEmpty){
                        islongpress=false;
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: tempList[index]==true? Colors.red: appPrimary,width: selectedId.isNotEmpty? 1.5: 1),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 130,
                            child: user.image==null || user.image==""? Image.asset(
                              "assets/images/person.jpg",
                              fit: BoxFit.cover,
                            ) : Image.network("${user.image}",fit: BoxFit.fill,),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconsTitle(svgPath: 'assets/icons/person.svg',title: user.name),
                                const SizedBox(height: 5,),
                                IconsTitle(iconPath: 'assets/images/callPng.png',title: user.mobileNumber),
                                const SizedBox(height: 5,),
                                IconsTitle(svgPath: 'assets/icons/email.svg',title: user.email),
                                const SizedBox(height: 5,),
                                IconsTitle(iconPath: 'assets/images/age.png',title: "${user.age ?? ""}",height: 21,width: 21,),
                                const SizedBox(height: 5,),
                                IconsTitle(svgPath: 'assets/icons/location.svg',title: user.address ?? ""),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                Positioned(
                  right: 0,
                  child:selectedId.isNotEmpty?
                  IconButton(
                      onPressed: (){
                        if(tempList[index]==false){
                          tempList[index]=true;
                        } else {
                          tempList[index]=false;
                        }
                        if(selectedId.contains(user.id)){
                          selectedId.removeAt(selectedId.indexOf(user.id));
                        } else {
                          selectedId.add(user.id);
                        }
                        // print("selected Index : $index => ${selectedId.elementAt(index)}");
                        if(selectedId.isEmpty){
                          islongpress=false;
                        }
                        setState(() {});
                      },
                        icon: Icon(tempList[index]==true?
                          Icons.check_circle_rounded:
                          Icons.circle_outlined
                      ),
                  ): PopupMenuButton(
                    onSelected: (value) async {
                      int click =value ;
                      int id= user.id;
                      if(value==0){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateUserScreen(
                                name: user.name,
                                email: user.email,
                                number: user.mobileNumber,
                                age: user.age,
                                address: user.address,
                                image: user.image,
                                id: id,
                              ),
                            ),
                        );
                      } else if(click==1){
                          var isDeleted =await context.read<ApiProvideClass>().apiDelete(id: id);
                          if(isDeleted.success == true){
                            users.removeAt(index);
                          }
                        }
                    },
                    offset: const Offset(-15, 50),
                    constraints: const BoxConstraints(
                        maxWidth: 120
                    ),
                    tooltip: "Delete / Edit",
                    icon: const Icon(Icons.more_vert,color: appPrimary,),
                    itemBuilder:(context) {
                      return buttonList.map((e) {
                        final int click=buttonList.indexOf(e);
                        return PopupMenuItem(
                          value: click,
                          child: CustomButton(
                            title: e["title"]!,
                            svgPath: e["svgPath"]!,
                            height: click==0 ? 22 : 25,
                            width: click==0 ? 22 : 25,
                            color: click==0 ? Colors.green : Colors.red,),
                        );
                      },).toList();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}