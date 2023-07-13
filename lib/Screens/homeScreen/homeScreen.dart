import 'package:api_project/ColorConsts.dart';
import 'package:api_project/Models/ApiModels.dart';
import 'package:api_project/api/apiCall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/IconTitle.dart';
import '../../widgets/customButton.dart';
import '../createUser/createUserScreen.dart';

class HomeScreen extends StatefulWidget {
  static const pageName="/home";
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
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context.read<apiProvideClass>().apiCall();
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
    final provider=context.watch<apiProvideClass>();
    final users=context.watch<apiProvideClass>().users;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
            for(int i=0; i<selectedId.length; i++) {
             final isdeleted = await context.read<apiProvideClass>().apiDelete(id: selectedId.elementAt(i));
             if(isdeleted==true){
               users.removeWhere((element) => element.id==selectedId[i]);
             }
            }
            // context.read<apiProvideClass>().apiCall();
            context.read<apiProvideClass>().tempList=List.filled(users.length, false);
            selectedId.clear();
          },
          icon: const Icon(Icons.delete))
        ],
      ),
      body: provider.isloading==true ?
      const Center(child: CircularProgressIndicator()): users!=null ?
      buildUi() : Text("Error"),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
           Navigator.pushNamed(context, CreateUserScreen.pageName);
           // //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2(),));
           //  setState(() {});
          },
          elevation: 0,
          backgroundColor: appPrimary.withOpacity(0.7),
          label: const Text("Add",style: TextStyle(color: Colors.white),),
          icon: const Icon(Icons.add,color: Colors.white,),),
    );
  }
  Padding buildUi() {
    final users= context.watch<apiProvideClass>().users;
    final tempList=context.watch<apiProvideClass>().tempList;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user=users.elementAt(index);
          return Stack(
            children: [
              InkWell(
                onTap: (){
                  if(tempList[index]==false){
                    tempList[index]=true;
                  } else {
                    tempList[index]=false;
                  }
                  setState(() {

                  });
                  if(selectedId.contains(user.id)){
                    selectedId.removeAt(selectedId.indexOf(user.id));
                    print("removed : ${user.id}");
                  } else {
                    selectedId.add(user.id);
                  }
                  // print("selected Index : $index => ${selectedId.elementAt(index)}");
                  print("Selected List : $selectedId");
                  print("temp List : $tempList");
                  setState(() {

                  });
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: tempList[index]==true? Colors.red: appPrimary),
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
                              IconsTitle(svgPath: 'assets/icons/person.svg',title: "${user.name}"),
                              const SizedBox(height: 5,),
                              IconsTitle(Icon: 'assets/images/callPng.png',title: "${user.mobile_number}"),
                              const SizedBox(height: 5,),
                              IconsTitle(svgPath: 'assets/icons/email.svg',title: "${user.email}"),
                              const SizedBox(height: 5,),
                              IconsTitle(Icon: 'assets/images/age.png',title: "${user.age==null? "" : user.age}",height: 21,width: 21,),
                              const SizedBox(height: 5,),
                              IconsTitle(svgPath: 'assets/icons/location.svg',title: "${user.address==null?"" : user.address}"),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Positioned(
                right: 0,
                child: PopupMenuButton(
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
                              number: user.mobile_number,
                              age: user.age,
                              address: user.address,
                              image: user.image,
                              id: id,
                            ),
                          ),
                      );
                    } else if(click==1){
                        bool isDeleted =await context.read<apiProvideClass>().apiDelete(id: id);
                        if(isDeleted == true){
                          users.removeAt(index);
                          print("ServiceList - Length : ${users.length}");
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
                        // onTap: () async {
                        //   int id= user.id;
                        //   if(click==1){
                        //     bool isDeleted =await context.read<apiProvideClass>().apiDelete(id: id);
                        //     if(isDeleted == true){
                        //       users.removeAt(index);
                        //       print("ServiceList - Length : ${users.length}");
                        //     }
                        //   }
                        //   else if(click==0){
                        //     Navigator.pop(context);
                        //     await Future.delayed(Duration(milliseconds: 500));
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserScreen(data: user),));
                        //     print(click);
                        //   }
                        // },
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
    );
  }
}