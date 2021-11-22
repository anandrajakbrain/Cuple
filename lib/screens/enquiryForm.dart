import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/inquiryFormResponse.dart';
import 'package:flutter/material.dart';

class EnquiryForm extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  var _formKey = GlobalKey<FormState>();
  String msg;
  InquiryFormResponse inquiryFormResponse;
  TextEditingController query=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: APP_BAR_COLOR,
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Text(
                  "Please Enter Your Query Here",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Text(
                  "${inquiryFormResponse != null ? inquiryFormResponse.message ?? "" : ''}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: query,
                    decoration: InputDecoration(
                      hintText: "Enter Here",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: 10,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Fill The Query";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {
                        msg = text;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      submit();
                      // register();
                      // beforeRagisterOtp();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Container(
                      padding: EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFF1E8FED), Color(0XFF6341DF)]),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit() async {

    InquiryFormResponse _inquiryFormResponse =
        await Plugs(context).submitInquiryForm(msg: msg);
    if (_inquiryFormResponse.success == true) {
      setState(() {
        inquiryFormResponse = _inquiryFormResponse;


      });
      query.text='';
      msg=null;
      setState(() {

      });
      print(query.text);
      print(msg);
      // Utils(context).showMessage(title: "Thank you",child: Text("${inquiryFormResponse.message??""}"));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => EnquiryForm()));
    }
  }
}
