import 'package:evcloud_app/dialogs/common_dialogs.dart';
import 'package:evcloud_app/helpers/app_localizations.dart';
import 'package:evcloud_app/models/user_model.dart';
import 'package:evcloud_app/screens/delete_account_screen.dart';
import 'package:evcloud_app/widgets/default_button.dart';
import 'package:flutter/material.dart';

class DeleteAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Center(
      child: DefaultButton(
        child: Text(i18n.translate("delete_account"),
            style: TextStyle(fontSize: 18)),
        onPressed: () {
          /// Delete account
          ///
          /// Confirm dialog
          infoDialog(context,
              icon: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white),
              ),
              title: '${i18n.translate("delete_account")} ?',
              message: i18n.translate(
                  'all_your_profile_data_will_be_permanently_deleted'),
              negativeText: i18n.translate("CANCEL"),
              positiveText: i18n.translate("DELETE"),
              negativeAction: () => Navigator.of(context).pop(),
              positiveAction: () async {
                // Close confirm dialog
                Navigator.of(context).pop();

                // Log out first
                UserModel().signOut().then((_) {
                  /// Go to delete account screen
                  Future(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DeleteAccountScreen()));
                  });
                });
              });
        },
      ),
    );
  }
}
