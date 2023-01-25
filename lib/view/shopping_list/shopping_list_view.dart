import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/shopping_list_cubit.dart';
import 'widgets/main_shopping_list_view.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.shopping_list),
          actions: [
            IconButton(
              onPressed: () => print("TODO: save changes"),
              icon: const Icon(Icons.save),
            ),
            IconButton(
              onPressed: () => print("TODO: add new product!"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            if (state is ShoppingListInitial) {
              context.read<ShoppingListCubit>().loadData();
              return const CircularProgressIndicator();
            }
            if (state is ShoppingListLoaded) {
              return MainShoppingListView(
                currentData: state.currentData,
              );
            }
            return const Scaffold();
          },
        ));
  }
}
