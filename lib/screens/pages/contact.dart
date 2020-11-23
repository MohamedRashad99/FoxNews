import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController messageController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController= TextEditingController();
    messageController = TextEditingController();

    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact US"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (isloading ) ? _loading() : _ContactForm() ,
      ),
    );
  }
  Widget _ContactForm(){
  return Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Your Name',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Your Name';
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Your Email'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Your Name';
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: messageController,
          decoration: InputDecoration(labelText: 'Message'),
          maxLines: 4,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Your Message';
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 24,
        ),

        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red.shade800)
            ),
            child: Text(
              'SEND MESSAGE',
              style: TextStyle(color: Colors.white ),
            ),
            color: Colors.red.shade800,
            onPressed: () {
              if(_formKey.currentState.validate()){


                  String name=nameController.text;
                  String email= emailController.text;
                  String message=messageController.text;
                   setState(() {
                     isloading =true;
                   });
              }else{
                setState(() {
                  isloading =false;
                });
              }
            },
          ),
        ),
      ],
    ),
  );
  }
  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
