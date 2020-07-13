

import 'package:flutter/material.dart';

class CarrinhoCompras extends StatelessWidget {
  const CarrinhoCompras({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      initialChildSize: 0.2,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          child: ListView.builder(
            controller: scrollController,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text('Item $index'));
            },
          ),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        );
      },
    );
  }
}
