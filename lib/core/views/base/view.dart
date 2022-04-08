// coverage:ignore-file

import 'package:flutter/widgets.dart';
import 'package:flutter_tech_exam/core/view_models/base/view_model.dart';
import 'package:flutter_tech_exam/shared/service_locator.dart';
import 'package:provider/provider.dart';

mixin ViewMixin<TViewModel extends ViewModel> {
  final _ViewModelDependencies<TViewModel> _viewModelDependencies = _ViewModelDependencies();

  TViewModel get viewModel => _viewModelDependencies.viewModel!;

  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider<TViewModel>(
      create: (_) => onCreateViewModel(context),
      dispose: (context, viewModel) => viewModel.dispose(),
      lazy: true,
      builder: (context, child) {
        _viewModelDependencies.viewModel = context.watch<TViewModel>();

        return buildView(context);
      },
    );
  }

  /// Builds the layout of this view.
  @protected
  Widget buildView(BuildContext context);

  TViewModel onCreateViewModel(BuildContext context) {
    final route = ModalRoute.of(context);
    final viewModel = locator<TViewModel>();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      viewModel.onInitialize(route?.settings.arguments);
    });

    return _viewModelDependencies.viewModel = viewModel;
  }
}

class _ViewModelDependencies<TViewModel extends ViewModel> {
  TViewModel? viewModel;
}
