import 'package:cam_doc_finder/landing/landing_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cam_doc_finder/login_page/login_page_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'documents_page/documents_page_widget.dart';
import 'my_profile_page/my_profile_page_widget.dart';
import 'messages/messages_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<CamDocFinderFirebaseUser> userStream;
  CamDocFinderFirebaseUser initialUser;
  final authUserSub = authenticatedUserStream.listen((_) {});
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    userStream = camDocFinderFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));

    SharedPreferences.getInstance().then((val) => {
          setState(() {
            prefs = val;
          })
        });
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CamDoc Finder',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('fr', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: initialUser == null || prefs == null
          ? Container(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/doc_finder_splash.png',
                  fit: BoxFit.contain,
                ),
              ),
            )
          : prefs.getBool('isFirstRun') == null
              ? LandingWidget(prefs: prefs)
              : currentUser.loggedIn
                  ? NavBarPage()
                  : LoginPageWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'DocumentsPage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'DocumentsPage': DocumentsPageWidget(),
      'MyProfilePage': MyProfilePageWidget(),
      'Messages': MessagesWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.home,
                size: 24,
              ),
              label: 'Home',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24,
              ),
              label: 'Profile',
              tooltip: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline_sharp,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.chat_bubble,
                size: 24,
              ),
              label: 'Messages',
              tooltip: 'Messages',
            )
          ],
          backgroundColor: FlutterFlowTheme.secondaryColor,
          currentIndex: tabs.keys.toList().indexOf(_currentPage),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xB9FFFFFF),
          onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting),
    );
  }
}
