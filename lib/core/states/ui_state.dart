import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../extensions/index.dart';
import '../resources/index.dart';

enum UITemplate { error, search, noData }

Center uiLoading() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(MyDimens.dp20),
      child: CircularProgressIndicator(color: MyColors.primary),
    ),
  );
}

Center uiTemplate(
  BuildContext context, {
  UITemplate template = UITemplate.noData,
  String message = 'No Data',
  String? displayMessage,
  bool includeImage = true,
  Function()? refreshAction,
}) {
  if (displayMessage != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 1), content: Text(displayMessage)),
      );
    });
  }
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (includeImage) ...[
          SvgPicture.asset(
            switch (template) {
              UITemplate.error => MyAssets.errorTemplate,
              UITemplate.noData => MyAssets.noDataTemplate,
              UITemplate.search => MyAssets.searchTemplate,
            },
            width: 240,
            fit: BoxFit.cover,
          ),
          MyDimens.dp20.height,
        ],
        Padding(
          padding: const EdgeInsets.all(MyDimens.dp20),
          child: Text(
            message,
            style: context.theme.textTheme.titleSmall?.copyWith(color: MyColors.grey),
            textAlign: TextAlign.center,
          ),
        ),
        if (refreshAction != null) ...[
          MyDimens.dp20.height,
          ElevatedButton(
            onPressed: refreshAction,
            child: const Text('Refresh'),
          )
        ],
      ],
    ),
  );
}
