import 'package:final_year_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: 25.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 15,
          ),
          const Text('Track My Order'),
          const SizedBox(
            width: 15,
          ),
          const Text('Customer Care'),
          const SizedBox(
            width: 15,
          ),
          const Text('About'),
          const SizedBox(
            width: 15,
          ),
          InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen())),
              child: const Text('Manage Account')),
          const SizedBox(
            width: 15,
          ),
          const Text('Sign Out'),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
