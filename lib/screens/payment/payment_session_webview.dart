import 'dart:convert';
import 'dart:typed_data';

import 'package:ewallet_app/models/ico_models.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentSessionWebView extends StatefulWidget {
  const PaymentSessionWebView({
    super.key,
    required this.session,
    this.title = 'Payment',
    this.onCompleted,
    this.successScheme = 'myapp',
  });

  final PaymentSession session;
  final String title;
  final VoidCallback? onCompleted;
  final String successScheme;

  @override
  State<PaymentSessionWebView> createState() => _PaymentSessionWebViewState();
}

class _PaymentSessionWebViewState extends State<PaymentSessionWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.toLowerCase().startsWith(widget.successScheme)) {
              widget.onCompleted?.call();
              Get.back();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _error = error.description;
                _isLoading = false;
              });
            }
          },
        ),
      );

    _loadSession();
  }

  void _loadSession() {
    final session = widget.session;
    if (!session.isValid) {
      setState(() {
        _error = 'Invalid payment session received.';
        _isLoading = false;
      });
      return;
    }

    final payload = json.encode({'request': session.requestPayload});
    _controller.loadRequest(
      Uri.parse(session.endpoint),
      method: LoadRequestMethod.post,
      headers: {
        'Content-Type': 'application/json',
        'X-VERIFY': session.checksum,
      },
      body: Uint8List.fromList(utf8.encode(payload)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: ThemeText.subtitle),
        actions: [
          IconButton(
            onPressed: _loadSession,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          if (_error != null)
            Center(
              child: Padding(
                padding: EdgeInsets.all(spacingUnit(2)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _error!,
                      style: ThemeText.subtitle2.copyWith(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _error = null;
                          _isLoading = true;
                        });
                        _loadSession();
                      },
                      style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
