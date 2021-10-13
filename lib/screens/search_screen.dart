import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/constants.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/repositories/firebase/auth_methods.dart';
import 'package:skype_flutter_clone/screens/chat_screens/chat_screen.dart';
import 'package:skype_flutter_clone/widgets/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _authMethods = AuthMethods();
  List<LocalUser>? userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      _authMethods.fetchAllUsers(user).then((List<LocalUser> list) {
        setState(() {
          userList = list;
        });
      }); // as FutureOr<dynamic> Function(void));
    });
    print(userList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      appBar: searchAppbar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
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

  buildSuggestions(String query) {
    final List<LocalUser> suggestionList = query.isEmpty || userList == null
        ? []
        : userList!.where((LocalUser user) {
            String _getUsername = user.username!.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name!.toLowerCase();
            bool matchUsername = _getUsername.contains(_query);
            bool matchName = _getName.contains(_query);
            return (matchName || matchUsername);
          }).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          LocalUser searchedUser = LocalUser(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username,
          );
          return CustomTile(
            mini: false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(receiver: searchedUser)));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(searchedUser.profilePhoto!),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              searchedUser.username!,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              searchedUser.name!,
              style: TextStyle(color: Constants.greyColor),
            ),
          );
        });
  }
}
