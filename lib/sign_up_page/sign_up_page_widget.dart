import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPageWidget extends StatefulWidget {
  SignUpPageWidget({Key key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  TextEditingController confPassFieldController;
  bool confPassFieldVisibility;
  TextEditingController emailFieldController;
  TextEditingController nameFieldController;
  TextEditingController phoneFieldController;
  TextEditingController passFieldController;
  bool passFieldVisibility;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    confPassFieldController = TextEditingController();
    confPassFieldVisibility = false;
    emailFieldController = TextEditingController();
    nameFieldController = TextEditingController();
    phoneFieldController = TextEditingController();
    passFieldController = TextEditingController();
    passFieldVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/images/docfinder_logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'CamDoc Finder',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Condiment',
                        color: Colors.white,
                        fontSize: 56,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 12, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x22EEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                          child: TextFormField(
                            controller: nameFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'This field is required';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 12, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x22EEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                          child: TextFormField(
                            controller: emailFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'This field is required';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 12, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x22EEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                          child: TextFormField(
                            controller: phoneFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Field is required';
                              }
                              if (val.length < 9) {
                                return 'Phone number should be atleast 9 numbers';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x22EEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: TextFormField(
                            controller: passFieldController,
                            obscureText: !passFieldVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passFieldVisibility =
                                      !passFieldVisibility,
                                ),
                                child: Icon(
                                  passFieldVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            textAlign: TextAlign.start,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'This field is required';
                              }
                              if (val.length < 6) {
                                return 'Password should be atleast 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x22EEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: TextFormField(
                            controller: confPassFieldController,
                            obscureText: !confPassFieldVisibility,
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
                              labelStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confPassFieldVisibility =
                                      !confPassFieldVisibility,
                                ),
                                child: Icon(
                                  confPassFieldVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() => _loadingButton1 = true);
                          try {
                            if (!formKey.currentState.validate()) {
                              return;
                            }
                            if (passFieldController.text !=
                                confPassFieldController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Passwords don't match!",
                                  ),
                                ),
                              );
                              return;
                            }

                            final user = await createAccountWithEmail(
                              context,
                              emailFieldController.text,
                              passFieldController.text,
                            );
                            if (user == null) {
                              return;
                            }

                            final usersCreateData = createUsersRecordData(
                              phoneNumber: phoneFieldController.text,
                            );
                            await UsersRecord.collection
                                .doc(user.uid)
                                .update(usersCreateData);

                            await Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: NavBarPage(initialPage: 'DocumentsPage'),
                              ),
                              (r) => false,
                            );
                          } finally {
                            setState(() => _loadingButton1 = false);
                          }
                        },
                        text: 'Join',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: Color(0xFF1062AE),
                          textStyle: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: 6,
                        ),
                        loading: _loadingButton1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0x19EEEEEE),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                            child: Text(
                              'OR',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lato',
                                color: Color(0xA5FFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0x19EEEEEE),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.03, 0.85),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  decoration: BoxDecoration(
                    color: Color(0x45EEEEEE),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0.93),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0.96),
                          child: Text(
                            'Already have an account?',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lato',
                              color: Color(0x7EFFFFFF),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0.96),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: LoginPageWidget(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login.',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lato',
                                  color: FlutterFlowTheme.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.02, 0.8),
                child: FFButtonWidget(
                  onPressed: () async {
                    setState(() => _loadingButton2 = true);
                    try {
                      final user = await signInWithGoogle(context);
                      if (user == null) {
                        return;
                      }
                      await Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: NavBarPage(initialPage: 'DocumentsPage'),
                        ),
                        (r) => false,
                      );
                    } finally {
                      setState(() => _loadingButton2 = false);
                    }
                  },
                  text: 'Join with Google',
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                  ),
                  options: FFButtonOptions(
                    width: 230,
                    height: 40,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 6,
                  ),
                  loading: _loadingButton2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
