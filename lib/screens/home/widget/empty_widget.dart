import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/emptytodo.png'),
                    fit: BoxFit.contain)),
          ),
          Text(
            "What do you want to do today?",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 15),
          Text("Tap + to add your tasks",style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
