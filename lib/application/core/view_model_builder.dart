import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  final T Function() initViewModel;
  final Widget Function(BuildContext context, T value) builder;

  const ViewModelBuilder({
    required this.initViewModel,
    required this.builder,
    super.key,
  });

  @override
  State<ViewModelBuilder<T>> createState() => _ViewModelBuilder<T>();
}

class _ViewModelBuilder<T extends BaseViewModel>
    extends State<ViewModelBuilder<T>> {
  late final T viewModel;
  bool _init = false;
  OverlayEntry? _overlayEntry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      viewModel = widget.initViewModel();
      viewModel.loadingOverlay = _loading;
      viewModel.dialog = _dialog;

      viewModel.onBindingCreated();
      _init = true;
    }
  }

  void _loading(bool loading) {
    if (loading) {
      _overlayEntry?.remove();
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.black.withOpacity(.1),
            ),
            const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  Future<void> _dialog(String title, String description) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider<T>.value(
        value: viewModel,
        child: Consumer<T>(
          builder: (context, viewModel, _) =>
              widget.builder(context, viewModel),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    viewModel.dispose();
    super.dispose();
  }
}
