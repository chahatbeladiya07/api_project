import 'package:api_project/color_consts.dart';
import 'package:api_project/api/api_call.dart';
import 'package:api_project/helpers/imageValidator.dart';
import 'package:api_project/widgets/MyTextFormField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  final String? name;
  final String? number;
  final String? email;
  final String? image;
  final int? age;
  final String? address;
  final int? id;
  const CreateUserScreen({
    super.key,
    this.name,
    this.number,
    this.email,
    this.image,
    this.age,
    this.address,
    this.id,
  });
  static const pageName = "/createUser";

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final Map<String, dynamic> userdata = {};
  // GlobalKey formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode imageFocus = FocusNode();
  @override
  void initState() {
    nameController=TextEditingController(text: widget.name);
    emailController=TextEditingController(text: widget.email);
    numberController=TextEditingController(text: widget.number);
    ageController=TextEditingController(text: widget.age!=null?"${widget.age}" : null);
    imageController=TextEditingController(text: widget.image);
    addressController=TextEditingController(text: widget.address);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    ageController.dispose();
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    imageController.dispose();
    addressController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    mobileFocus.dispose();
    ageFocus.dispose();
    addressFocus.dispose();
    imageFocus.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ApiProvideClass>();
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New User"),
          leading:  IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,)),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextFormField(
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(mobileFocus),
                  controller: nameController,
                  hintText: "Name",
                  label: "*",
                  maxLines: 1,
                  validator: (validate) {
                    if (validate == null || validate.isEmpty) {
                      return "Name can't be empty";
                    } else if (validate.trim() == "") {
                      return "Enter valid name";
                    } else {
                      return null;
                    }
                  },
                ),
                MyTextFormField(
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(emailFocus),
                  focusNode: mobileFocus,
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  hintText: "Mobile Number",
                  label: "*",
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  validator: (validate) {
                    if (validate == null || validate.isEmpty) {
                      return "mobile number can't be empty";
                    } else if (validate.length != 10) {
                      return "mobile number must be of 10 digit";
                    } else if (validate.startsWith("0")) {
                      return "mobile number can't start with 0";
                    } else {
                      return null;
                    }
                  },
                ),
                MyTextFormField(
                  // initialValue: widget.email,
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(ageFocus),
                  focusNode: emailFocus,
                  controller: emailController,
                  hintText: "Email Address",
                  label: "*",
                  maxLines: 1,
                  validator: (validate) {
                    if (validate == null || validate.isEmpty) {
                      return "Email can't be empty";
                    } else if (EmailValidator.validate(
                            emailController.text.trim()) ==
                        false) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  // initialValue: "${widget.age}",
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(imageFocus),
                  focusNode: ageFocus,
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  hintText: "Age",
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  validator: (validate) {
                    if (ageController.text != "") {
                      int age = int.parse(ageController.text.toString());
                      if (validate!.length > 3 || age > 150 || age <= 0) {
                        return "please enter valid Age";
                      }
                    } else {
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(addressFocus),
                  focusNode: imageFocus,
                  controller: imageController,
                  hintText: "ImageUrl",
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  onFieldSubmitted: (p0) {
                    onPressed();
                  },
                  keyboardType: TextInputType.text,
                  focusNode: addressFocus,
                  controller: addressController,
                  hintText: "Address",
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: appPrimary,
          onPressed: onPressed,
          label:widget.name==null? provider.isLoadingForSave == true
              ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ) :provider.isLoadingForPut? const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ) : const Text("Update",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  void onPressed() async {
    if(widget.name!=null){
      context.read<ApiProvideClass>().isLoadingForPut;
    } else {
      context.read<ApiProvideClass>().isLoadingForSave;
    }
    //nothing
    bool isvalid = true;
    if (imageController.text.trim().isNotEmpty) {
      final image = await imageValidate(url: imageController.text.trim());
      isvalid = image;
      if (isvalid == false) {
        Fluttertoast.showToast(msg: "Invalid URL");
      }
    }
    if (_formKey.currentState!.validate() &&
        isvalid == true &&
        _formKey.currentState != null) {
      final Map<String, dynamic> userdata = {
        'name': nameController.text.trim().toString(),
        'mobile_number': numberController.text.toString(),
        'email': emailController.text.trim().toString(),
        if (imageController.text.trim() != "")
          'image': imageController.text.trim(),
        if (addressController.text.trim() != "")
          'address': addressController.text.trim(),
        if (ageController.text.trim() != "")
          'age': int.parse(ageController.text.trim()),
      };
      if(widget.name!=null){
        // ignore: use_build_context_synchronously
        await context.read<ApiProvideClass>().putApi(id: widget.id!, user: userdata).then((value) async {
          if(value.success==true){
            await context.read<ApiProvideClass>().apiCall();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        });

      } else {
        // ignore: use_build_context_synchronously
        await context.read<ApiProvideClass>().postApi(userData: userdata).then((value) async {
          if(value.success==true){
            await context.read<ApiProvideClass>().apiCall();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        });
      }

    }
  }
}
