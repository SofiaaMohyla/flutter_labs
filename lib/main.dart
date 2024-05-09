// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Magical Counter',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         hintColor: Colors.pinkAccent,
//         fontFamily: 'Merienda',
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.indigo,
//         ),
//       ),
//       home: const MyHomePage(title: 'Magical Counter'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   TextEditingController _textEditingController = TextEditingController();

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   void _resetCounter() {
//     setState(() {
//       _counter = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: TextStyle(
//             fontFamily: 'Pacifico',
//             fontSize: 28,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: () {
//               // Add your info action here
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.indigo, Colors.deepPurple],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 70,
//                 child: Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                   size: 80,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Wondrous Counter',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 '$_counter',
//                 style: TextStyle(
//                   fontSize: 64,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.yellow,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextField(
//                   controller: _textEditingController,
//                   decoration: InputDecoration(
//                     labelText: 'Magical Incantation',
//                     labelStyle: TextStyle(color: Colors.white),
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.pinkAccent),
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           String enteredText = _textEditingController.text.trim();
//           if (enteredText.toLowerCase() == "avada kedavra") {
//             _resetCounter();
//           } else {
//             _incrementCounter();
//           }
//         },
//         tooltip: 'Cast Spell',
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.pinkAccent,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lab1sample2/global.dart';
import 'package:lab1sample2/home.dart';
import 'package:lab1sample2/login.dart';
import 'package:lab1sample2/prof.dart';
import 'package:lab1sample2/reg.dart';
import 'package:lab1sample2/storage/secure_user_storage.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Барбершоп',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/', // Початковий маршрут
      routes: {
        '/': (context) => MyHomePage(),
        '/registration': (context) => Reg(),
        '/profile': (context) => Prof(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Про нас', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.grey[200],
      ),
      body: const Center(
        child: Text(
          'Барбершоп',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: DrawerMain(selected: 'about'),
    );
  }
}

class DrawerMain extends StatefulWidget {
  DrawerMain({Key? key, required this.selected}) : super(key: key);

  final String selected;

  @override
  DrawerMainState createState() => DrawerMainState();
}

class DrawerMainState extends State<DrawerMain> {
  // Додаємо змінну для збереження стану авторизації
  bool _isAuthenticated = false;

  // Метод для перевірки авторизації користувача
  void checkAuthentication() async {
    _isAuthenticated = authManager.isUserAuthenticated();
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication(); // Перевірка при ініціалізації стану
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: const Text(
              'Барбершоп',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            selected: widget.selected == 'about',
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('Про нас', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          if (!_isAuthenticated) ListTile(
            selected: widget.selected == 'registration',
            leading: const Icon(Icons.person_add, color: Colors.blue),
            title: const Text('Реєстрація', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/registration');
            },
          ),
          if (_isAuthenticated) ListTile(
            selected: widget.selected == 'profile',
            leading: const Icon(Icons.account_circle, color: Colors.blue),
            title: const Text('Профіль', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            selected: widget.selected == 'home',
            leading: const Icon(Icons.home, color: Colors.blue),
            title: const Text('Домашня сторінка', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          if (!_isAuthenticated) ListTile(
            selected: widget.selected == 'login',
            leading: const Icon(Icons.login, color: Colors.blue),
            title: const Text('Увійти', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}