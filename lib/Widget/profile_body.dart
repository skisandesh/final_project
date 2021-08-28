import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/firebase_services/userinfo.dart';
import 'package:final_year_project/screens/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  var hasAddress = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: Text(
                  'Manage Account',
                  style: Constants.headingPrimaryText,
                ),
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, EditProfileScreen.routeName),
                  child: Row(
                    children: const [Text('Edit'), Icon(Icons.edit)],
                  ))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: UserService().getUserInfo(),
              builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    Map<String, dynamic> loading = {
                      'email': 'loading',
                      'username': 'loading',
                      'phoneNumber': 'loading'
                    };
                    return body(context, loading, 'Personal Info');
                  } else {
                    Map<String, dynamic> userData =
                        snapShot.data!.data() as Map<String, dynamic>;
                    return body(context, userData, 'Personal Info');
                  }
                } else {
                  Map<String, dynamic> error = {
                    'email': 'loading',
                    'username': 'loading',
                    'phoneNumber': 'loading'
                  };
                  return body(context, error, 'Personal Info');
                }
              }),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: UserService().getUserInfo(),
              builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    Map<String, dynamic> loading = {
                      'email': 'loading',
                      'username': 'loading',
                      'phoneNumber': 'loading'
                    };
                    return personalInfoCard(context, loading, 'Address', false);
                  } else {
                    Map<String, dynamic> userData =
                        snapShot.data!.data() as Map<String, dynamic>;
                    return personalInfoCard(
                        context, userData, 'Address', false);
                  }
                } else {
                  Map<String, dynamic> error = {
                    'email': 'loading',
                    'username': 'loading',
                    'phoneNumber': 'loading'
                  };
                  return personalInfoCard(context, error, 'Address', false);
                }
              }),
        ],
      ),
    );
  }

  Widget _userData(String type, userdata) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$type :',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        Text(
          userdata,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }

  Widget personalInfoCard(context, userdata, title, isAddress) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Text(
            title.toString(),
            style: Constants.headingPrimaryText,
          ),
          Container(
            color: Colors.grey[200],
            width: Adaptive.isMobile(context)
                ? MediaQuery.of(context).size.width * 0.8
                : 500,
            height: 150,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _userData(
                    isAddress ? 'User Name' : 'State',
                    isAddress
                        ? '${userdata['username']}'
                        : '${userdata['state']}'),
                _userData(
                    isAddress ? 'Email' : 'VDC/Municipality',
                    isAddress
                        ? '${userdata['email']}'
                        : '${userdata['vdcMun']}'),
                _userData(
                    isAddress ? 'Phone Number' : 'City',
                    isAddress
                        ? '${userdata['phoneNumber']}'
                        : '${userdata['city']}'),
                _userData(
                    isAddress ? 'Sex' : 'Location',
                    isAddress
                        ? '${userdata['sex']}'
                        : '${userdata['location']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget body(context, userdata, title) {
    return Adaptive.isMobile(context)
        ? Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                backgroundImage: NetworkImage('${userdata['imgUrl']}'),
              ),
              const SizedBox(
                height: 30,
              ),
              personalInfoCard(context, userdata, title, true),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                backgroundImage: NetworkImage('${userdata['imgUrl']}'),
              ),
              const SizedBox(
                height: 30,
              ),
              personalInfoCard(context, userdata, title, true),
            ],
          );
  }
}
