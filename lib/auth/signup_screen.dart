import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medical/auth/login_screen.dart';
import 'package:medical/dashboard/main_dashboard.dart';
import 'package:medical/func/util.dart';
import 'package:medical/services/auth_method.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool passwordVisible = false;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "Doctor Registration",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : CircleAvatar(
                        radius: 59,
                        backgroundImage: NetworkImage(
                            'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 70,
                    child: IconButton(
                        onPressed: () => selectImage(),
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        )))
              ],
            ),
            SizedBox(
              height: 23,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  border: InputBorder.none,
                  hintText: "Enter your name",
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                  hintStyle:
                      GoogleFonts.inter(fontSize: 16, color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onTap: () {
                  _selectDate();
                },
                controller: dateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  border: InputBorder.none,
                  hintText: "Date of Birth",
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.gif_box,
                        color: Colors.black,
                      )),
                  hintStyle:
                      GoogleFonts.inter(fontSize: 16, color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  border: InputBorder.none,
                  hintText: "Enter your email",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/email.png",
                      height: 10,
                      width: 10,
                    ),
                  ),
                  hintStyle:
                      GoogleFonts.inter(fontSize: 16, color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  border: InputBorder.none,
                  hintText: "Enter your password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/lock.png",
                      height: 10,
                      width: 10,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  hintStyle:
                      GoogleFonts.inter(fontSize: 16, color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: hospitalController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  border: InputBorder.none,
                  hintText: "Hospital Name",
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.local_hospital)),
                  hintStyle:
                      GoogleFonts.inter(fontSize: 16, color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'I agree to the medidoc \n Terms of Service and Privacy Policy',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
                value: true,
                onChanged: (bool? value) {},
              ),
            ),
            isPressed
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Name is Required")));
                        }
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Name is Required")));
                        } else if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email is Required")));
                        } else if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password is Required")));
                        } else if (dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("DOB is Required")));
                        } else if (hospitalController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Hospital is Required")));
                        } else {
                          setState(() {
                            isPressed = true;
                          });

                          String rse = await AuthMethods().signUpUser(
                              email: emailController.text,
                              dob: dateController.text,
                              pass: passwordController.text,
                              hospitalName: hospitalController.text,
                              username: nameController.text,
                              file: _image!);

                          print(rse);
                          setState(() {
                            isPressed = false;
                          });
                          if (rse != 'sucess') {
                            showSnakBar(rse, context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainDashboard()));
                          }
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Color(0xff199A8E),
                          fixedSize: Size(327, 60)),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => LoginScreen()));
                },
                child: Text.rich(
                    TextSpan(text: 'I have an account ', children: <InlineSpan>[
                  TextSpan(
                    text: 'Sign IN',
                    style: GoogleFonts.workSans(
                        color: Color(0xff199A8E),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
