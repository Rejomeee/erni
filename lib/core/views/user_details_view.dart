import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/common/route_names.dart';
import 'package:flutter_tech_exam/core/view_models/user_details_view_model.dart';
import 'package:flutter_tech_exam/core/views/base/view.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: Widget)
@Named(RouteNames.userDetails)
class UserDetailsView extends StatelessWidget with ViewMixin<UserDetailsViewModel> {
  UserDetailsView() : super(key: const Key(RouteNames.userDetails));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
    );
  }
}
