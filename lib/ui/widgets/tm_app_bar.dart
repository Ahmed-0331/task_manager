import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromUpdateProfileScreen = false,
  });

  final bool fromUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: (){
          if(!fromUpdateProfileScreen){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
          }

        },
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ahmed Joha',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white
                  ),
                ),
                Text('ahmedjoha123@gmail.com',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){
          AuthController.clearUserData();
          Navigator.pushNamedAndRemoveUntil(context, '/Login', (predicate)=>false);
        }, icon: Icon(Icons.logout))
      ],
    );
  }
  @override
  Size get preferredSize =>Size.fromHeight(kToolbarHeight);
}
