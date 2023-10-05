import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavPopButton extends StatelessWidget {
  const NavPopButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27.0, top: 37),
      child: InkWell(
        onTap: () {
          context.router.pop();
        },
        enableFeedback: false,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 16,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: const Padding(
            padding: EdgeInsets.all(1.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
