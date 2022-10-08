import 'package:flutter/material.dart';

class EmptyBookGridTile extends StatelessWidget {
  const EmptyBookGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 11,
            child: Container(
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 9),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 9),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
