import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'base_view_model_protocol.dart';

class BaseViewModel extends ChangeNotifier with BaseViewModelProtocol {
  bool _showLoading = false;

  void onBindingCreated() {}

  bool get showLoading => _showLoading;

  set showLoading(bool value) {
    _showLoading = value;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadingOverlay(value);
    });
  }

  Future<void> flow<T extends Object?>(
    final Function callback, {
    final ValueChanged<T>? onSuccess,
    final bool showLoading = true,
  }) async {
    this.showLoading = showLoading;

    notifyListeners();

    try {
      final T data = await callback();
      onSuccess?.call(data);
    } on DioError catch (e, _) {
      dialog('Error', e.message ?? 'Something went wrong');
    } catch (e, _) {
      dialog('Error', e.toString());
    } finally {
      this.showLoading = false;
      notifyListeners();
    }
  }
}
