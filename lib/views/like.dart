import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Like extends StatelessWidget {
  const Like({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogEntry>(builder: (ctx, entry, _) {
      return Row(
        children: [
          entry.totalLikes > 0 ? Text(entry.totalLikes.toString()) : const Text(" "),
          IconButton(
            onPressed: () { 
              final loggedIn = Provider.of<BlogApi?>(context, listen: false)?.isLoggedIn() ?? false; // to allow testing without blogapi provider setup, listen false to prevent rebuild loop
              if (loggedIn) {
                entry.toggleLike();
              } else {
                final snackbarInfo = SnackBar(
                  content: Text(AppLocalizations.of(ctx)!.loginFirst),
                  action: SnackBarAction(label: AppLocalizations.of(ctx)!.login, onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView())); })
                  );
                ScaffoldMessenger.of(context).showSnackBar(snackbarInfo);
              }
              
            },
            icon: Icon(entry.liked ? Icons.favorite : Icons.favorite_border))
        ]);
    });
  }
}
