import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/view/product_list/cubit/product_list_cubit.dart';

class ProductListView extends StatefulWidget {
  final ProductList currentData;
  const ProductListView({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<ProductListElement> productList = widget.currentData.productList;
  int lastPos = 1;

  void decreaseAmount(ProductListElement product) {
    if (product.currentAmount! > 0) {
      product.currentAmount = product.currentAmount! - 1;
      context.read<ProductListCubit>().updateProduct(product);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    productList.sort(
      (a, b) => a.product!.compareTo(b.product!),
    );
    return ListView.builder(
      itemCount: widget.currentData.count,
      itemBuilder: (context, index) {
        return BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, state) {
            return GestureDetector(
              onDoubleTap: () => decreaseAmount(productList[index]),
              onLongPress: () => Navigator.pushNamed(context, EDIT_PRODUCT,
                  arguments: productList[index]),
              child: ListTile(
                selected: productList[index].selected,
                leading: const SizedBox(
                  height: double.infinity, // center icon
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ),
                ),
                title: Text(productList[index].product!),
                trailing: Text(
                    "${productList[index].currentAmount.toString()}/${productList[index].targetAmount.toString()}"),
                subtitle: Text(productList[index].source!),
              ),
            );
          },
        );
      },
    );
  }
}
