import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/onbording/contactsupport/controller/controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class Contactsupport extends GetWidget<ContactSupportController> {
  Contactsupport({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonUi.appBar(),
                  Text('Contact Support',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                  SizedBox()
                ],
              ),
              SizedBox(height: 25,),
              Expanded(
                child: Form(
                  key: _formKey,
                    child: ListView(
                      children: [
                        // Phone Number
                        TextFormField(
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            hintText: "Mobile number",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            filled: true,
                            fillColor: clrGreyLight,
                            prefixIcon: CountryCodePicker(
                              onChanged: (code) {
                                debugPrint("===${code.runtimeType}");
                                controller.changeCountryCode(code);
                                },
                              initialSelection: controller.initialSelection.value,
                              favorite: ['+31',],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
        
                        // Message
                        TextFormField(
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            filled: true,
                            fillColor: clrGreyLight,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
        
                        // Email
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            filled: true,
                            fillColor: clrGreyLight,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
        
                        // Name
                        TextFormField(
                          controller: controller.firstnameController,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            filled: true,
                            fillColor: clrGreyLight,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
        
                        // Name
                        TextFormField(
                          controller: controller.lastnameController,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            filled: true,
                            fillColor: clrGreyLight,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
        
                        // Submit Button
                        Obx(() {
                          return Opacity(
                            opacity: controller.conloading.value ? 0.5 : 1,
                            child: CustomElevatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.contactsupport();
                                }
                              },
                              backgroundClr: clrBlacke,
                              child: controller.conloading.value ? CommonUi.buttonLoading() : Text('Submit',style: TextStyle(color: clrWhite),),
                            ),
                          );
                        })
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

