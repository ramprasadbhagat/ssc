import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ssc/presentation/utils/image_path.dart';

enum LoadingShimmerType {
  withChild,
  tile,
  logo,
  // circular,
  // product,
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer._({
    super.key,
    required this.type,
    this.child,
    this.enabled,
    this.line,
    this.center = true,
  });
  final LoadingShimmerType type;
  final Widget? child;
  final bool? enabled;
  final int? line;
  final bool center;

  factory LoadingShimmer.withChild({
    required Widget child,
    bool enabled = true,
    bool center = true,
  }) {
    return LoadingShimmer._(
      type: LoadingShimmerType.withChild,
      enabled: enabled,
      center: center,
      child: child,
    );
  }

  factory LoadingShimmer.tile({
    bool enabled = true,
    int line = 1,
  }) {
    return LoadingShimmer._(
      type: LoadingShimmerType.tile,
      enabled: enabled,
      line: line,
    );
  }

  factory LoadingShimmer.logo({Key? key}) {
    return LoadingShimmer._(
      type: LoadingShimmerType.logo,
      key: key,
    );
  }

  // factory LoadingShimmer.circular() =>
  //     const LoadingShimmer._(type: LoadingShimmerType.circular);

  // factory LoadingShimmer.product() => const LoadingShimmer._(
  //       type: LoadingShimmerType.product,
      // );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoadingShimmerType.withChild:
        return _WithChild(
          enabled: enabled!,
          center: center,
          child: child!,
        );
      case LoadingShimmerType.logo:
        return const _Logo();
      case LoadingShimmerType.tile:
        return _Tile(enabled: enabled!, line: line!);
      // case LoadingShimmerType.circular:
      //   return LoadingAnimationWidget.discreteCircle(
      //     key: WidgetKeys.loader,
      //     color: ZPColors.primary,
      //     secondRingColor: ZPColors.secondary,
      //     thirdRingColor: ZPColors.orange,
      //     size: 30,
      //   );
      // case LoadingShimmerType.product:
      //   return const MaterialLoading();
    }
  }
}


class _WithChild extends StatelessWidget {
  const _WithChild({
    required this.child,
    required this.enabled,
    this.center = true,
  });
  final Widget child;
  final bool enabled;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final widget = !enabled
        ? child
        : Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            enabled: true,
            child: child,
          );

    return center ? Center(child: widget) : widget;
  }
}



class _Tile extends StatelessWidget {
  const _Tile({
    required this.enabled,
    required this.line,
  });
  final int line;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.white54,
        highlightColor: Colors.white,
        enabled: enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.filled(
            line,
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return _WithChild(
      enabled: true,
      child: Image.asset(
        ImagePath.appLogo,
        height: 30,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

