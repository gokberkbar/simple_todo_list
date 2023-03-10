mixin BaseViewModelProtocol {
  late void Function(bool loading) loadingOverlay;
  late Future<void> Function(String title, String descrion) dialog;
}
