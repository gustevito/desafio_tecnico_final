import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            ImageIcon(
              AssetImage('assets/logos/ebooks.png'),
              size: 300,
            ),

            //button
            MyButton(
              onTap: () => Navigator.pushNamed(context, '/home'),
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
