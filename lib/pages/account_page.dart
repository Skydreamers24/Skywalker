import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/pages/page_content.dart';
import 'package:skywalker/widgets/cards/contact_card.dart';
import 'package:skywalker/widgets/cards/user_card.dart';
import 'package:skywalker/widgets/other/sign_out_button.dart';

class AccountPage extends StatefulWidget {
  static const userCardFront = UserCardFront();

  const AccountPage({super.key});

  static List<Widget> widgets(BuildContext context) {
    return [
      const ContactCardWide(),
      const CustomSignOutButton()
    ];
  }

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var account = Account.of(context);
    return PageContent(
      title: "Account",
      trailing: IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.language)),
      children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxHeight: 250),
              child: AspectRatio(
                aspectRatio: 1.588,
                child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: AccountPage.userCardFront,
                    back: UserCardBack(
                      account: account,
                    )),
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ] +
          AccountPage.widgets(context),
    );
  }
}
