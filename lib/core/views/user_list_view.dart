import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/common/route_names.dart';
import 'package:flutter_tech_exam/core/view_models/user_list_view_model.dart';
import 'package:flutter_tech_exam/core/views/base/view.dart';
import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: Widget)
@Named(RouteNames.userList)
class UserListView extends StatelessWidget with ViewMixin<UserListViewModel> {
  UserListView() : super(key: const Key(RouteNames.userList));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Rebuild only this part of the UI when `counter` changes
            ValueListenableBuilder<List<UserEntity>>(
              valueListenable: viewModel.users,
              builder: (context, users, child) {
                return users.isEmpty
                    ? const Center(
                        child: Text('No users'),
                      )
                    // TODO: Show list of users and navigate to `UserDetailsView` when tapped
                    : Center(
                        child: Text('There are ${users.length} users'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
