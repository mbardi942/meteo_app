import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      required this.title,
      this.backButtonDisabled = false,
      this.onRefresh,
      this.onEditable,
      this.editableIcon
      });

  String title;
  void Function()? onRefresh;
  bool backButtonDisabled;
  void Function()? onEditable;
  IconData? editableIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 24)),
      centerTitle: true,
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      actions: [
          // if(showSettings == true)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 4),
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Theme.of(context).colorScheme.surface),
          //   child: IconButton(
          //     onPressed:()  {
          //         Navigator.pushNamed(context, '/settings' );
          // // Navigator.pushNamed(context, '/overview_weather', arguments: weather);

          //     },
          //     icon: Icon(Icons.settings),
          //   ),
          // ),
          if(onEditable != null) Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface),
            child: IconButton(
              // isSelected: true,
              onPressed: onEditable!,
              icon: Icon(editableIcon),
            ),
          ),
          const SizedBox(width: 4,),
           if (onRefresh != null)
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface),
            child: IconButton(
              onPressed: onRefresh!,
              icon: const Icon(Icons.refresh),
            ),
          ),
      ],

      leading: backButtonDisabled
          ? null
          : Center(
              child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 12),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),),
    );
  }
}
