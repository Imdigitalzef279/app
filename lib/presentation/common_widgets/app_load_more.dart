import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:solar_energy/application/constants/app_color.dart';

class AppLoadMore extends StatefulWidget {
  final Function? onRefresh;
  final Function? onLoadMore;
  final Widget child;
  final bool? reverse;

  const AppLoadMore({
    super.key,
    this.onRefresh,
    this.onLoadMore,
    this.reverse,
    required this.child,
  });

  @override
  State<AppLoadMore> createState() => _AppLoadMoreState();
}

class _AppLoadMoreState extends State<AppLoadMore> {
  final RefreshController _refreshController = RefreshController();
  late bool enablePullUp;
  late bool enablePullDown;

  @override
  void initState() {
    super.initState();
    enablePullUp = widget.onLoadMore != null;
    enablePullDown = widget.onRefresh != null;
  }

  Future<void> _onRefresh() async {
    if (enablePullDown) {
      widget.onRefresh!.call();
      _refreshController.refreshCompleted();
    }
  }

  Future<void> _onLoadMore() async {
    if (enablePullUp) {
      widget.onLoadMore!.call();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown,
      header: const MaterialClassicHeader(color: AppColors.textPrimary),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      footer: const ClassicFooter(loadStyle: LoadStyle.HideAlways),
      reverse: widget.reverse,
      child: widget.child,
    );
  }
}
