import 'package:finalproject/services/authentication_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget{
  final Function toggleScreen;

  const Register({Key key, this.toggleScreen}) : super(key: key);
  @override
  _RegisterState createState()=> _RegisterState();
}

class _RegisterState extends State<Register>{
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController= TextEditingController();
    super.initState();

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();

  }



  @override
  Widget build(BuildContext context){
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.green,), onPressed: (){},
                  ),
                  SizedBox(height: 60),
                  Text("Welcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10),
                  Text("Create Account to continue",style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                  ),),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (val)=>
                    val.isNotEmpty?null : "Please enter a email address",
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )

                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (val)=>
                    val.length < 6 ? "Enter more than 6 char" : null,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )

                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: ()async{
                      if(_formkey.currentState.validate()){
                        print("Email : ${_emailController.text}");
                        print("Email : ${_passwordController.text}");
                        await loginProvider.register(_emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      }
                    },
                    height: 70,
                    minWidth: loginProvider.isLoading? null : double.infinity,
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: loginProvider.isLoading ? CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                    :Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?"),
                      SizedBox(width: 10),
                      TextButton(onPressed: ()=>widget.toggleScreen(),
                        child: Text("Login"),
                      )
                    ],
                  ),

                  SizedBox(height: 20),
                  if(loginProvider.errorMessage != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color : Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(icon: Icon(Icons.close),
                        onPressed: ()=> loginProvider.setMessage(null),
                        ),
                      ),
                    )






                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}