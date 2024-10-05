import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/auth/auth_bloc.dart';

class CustomSnackbar {
  static OverlayEntry? _overlayEntry;

  static void showErrorMessage(BuildContext context, String message) {
    if (message == 'Unauthorized') {
      context.read<AuthBloc>().add(AuthOutEvent());
      _show(context, 'Token Got Expired', isError: true);
    } else {
      _show(context, message, isError: true);
    }
  }

  static void showSuccessMessage(BuildContext context, String message) {
   _show(context, message,);
  }

  static void _show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2), bool isError = false}) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => _SnackbarContent(
        message: message,
        duration: duration,
        isError: isError,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void dismiss() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class _SnackbarContent extends StatefulWidget {
  final String message;
  final Duration duration;
  final bool isError;

  const _SnackbarContent(
      {required this.message, required this.duration, required this.isError});

  @override
  __SnackbarContentState createState() => __SnackbarContentState();
}

class __SnackbarContentState extends State<_SnackbarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((value) {
          if (mounted) {
            CustomSnackbar.dismiss();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isError
                  ? Colors.redAccent.shade200
                  : Colors.green.shade300,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    if (mounted) {
                      _controller.reverse().then((value) {
                        if (mounted) {
                          CustomSnackbar.dismiss();
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
