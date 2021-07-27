import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FireBaseRepository _repository = FireBaseRepository();
  List<LocalUser>? userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repository
        .getCurrentUser()
        .then((user) => _repository.fetchAllUsers(user).then((users) {
              setState(() {
                users = users;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: searchAppbar(context),
    );
  }

  searchAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.gradientColorStart,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: Constants.blackColor,
            autofocus: true,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0X88ffff))),
          ),
        ),
      ),
    );
  }
// searchAppbar(BuildContext context) {
//   return AppBar(
//
//     flexibleSpace: Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [
//           Constants.gradientColorStart,
//           Constants.gradientColorEnd
//         ], begin: Alignment.centerLeft, end: Alignment.centerRight),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () => Navigator.pop(context),
//           ),
//           PreferredSize(
//               preferredSize: const Size.fromHeight(kToolbarHeight + 20),
//           child: Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: TextField(
//               controller: searchController,
//               onChanged: (val) {
//                 setState(() {
//                   query = val;
//                 });
//               },
//               cursorColor: Constants.blackColor,
//               autofocus: true,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 35
//               ),
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white,),
//                   onPressed: () {searchController.clear();},
//                 ),
//                 border: InputBorder.none,
//                 hintText: "Search",
//                 hintStyle: TextStyle(
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0X88ffff)
//                 )
//               ),
//             ),
//           ),),
//         ],
//       ),
//     ),
//   );
// }
}
