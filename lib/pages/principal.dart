// import 'package:doctor_app/pages/home_page.dart';
// import 'package:doctor_app/res/dimens.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class Principal extends StatelessWidget {
//   const Principal({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.blue,
//         backgroundColor: Colors.white,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.save_2),
//             label: "Visits",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.message),
//             label: "Message",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Iconsax.user),
//             label: "Profile",
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 1:
//               Navigator.pushNamed(context, '/visits');
//               break;
//             case 2:
//               Navigator.pushNamed(context, '/message');
//               break;
//             case 3:
//               Navigator.pushNamed(context, '/profile');
//               break;
//           }
//         },
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(AppDimensions.baseSize * 2),
//         child: const SingleChildScrollView(
//           child: Column(
//             children: [
//               HomePage()

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
