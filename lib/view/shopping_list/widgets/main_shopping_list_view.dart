import 'package:flutter/material.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/shopping_list.dart';

class MainShoppingListView extends StatefulWidget {
  final ShoppingListModel currentData;
  const MainShoppingListView({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  @override
  State<MainShoppingListView> createState() => _MainShoppingListViewState();
}

class _MainShoppingListViewState extends State<MainShoppingListView> {
  late List<ShoppingListElement> shoppingList = widget.currentData.shoppingList;
  int lastPos = 1;
  @override
  Widget build(BuildContext context) {
    shoppingList.sort(
      (a, b) => a.position.compareTo(b.position),
    );
    return ListView.builder(
        itemCount: widget.currentData.length(),
        itemBuilder: (context, index) {
          return ListTile(
            selected: shoppingList[index].selected,
            onTap: () => shoppingList[index].selected
                ? setState(() {
                    shoppingList[index].position = 0;
                    shoppingList[index].selected = false;
                  })
                : setState(() {
                    lastPos += 1;
                    shoppingList[index].position = lastPos;
                    shoppingList[index].selected = true;
                  }),
            onLongPress: () => Navigator.pushNamed(
              context,
              EDIT_SHOPPING_LIST,
              arguments: shoppingList[index]
            ),
            leading: SizedBox(
              height: double.infinity, // center icon
              child: Icon(
                Icons.shopping_cart,
                color:
                    shoppingList[index].selected ? Colors.green : Colors.grey,
              ),
            ),
            title: Text(shoppingList[index].value),
            trailing: Text(shoppingList[index].count.toString()),
            subtitle: Text(shoppingList[index].market),
          );
        });
  }
}