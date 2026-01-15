import 'package:flutter/material.dart';

class Menu{

  IconData iconData;
  String title;
  Color color;

  Menu({required this.iconData, required this.title, required this.color});

  static List<Menu> list = [
    Menu(iconData: Icons.person, title: "Transfert", color: Colors.blue.shade900),
    Menu(iconData: Icons.shopping_cart, title: "Paiement", color: Colors.orangeAccent),
    Menu(iconData: Icons.phone_android_outlined, title: "Crédit", color: Colors.blue),
    Menu(iconData: Icons.account_balance, title: "Banque", color: Colors.red),
    Menu(iconData: Icons.credit_card, title: "Carte", color: Colors.purple),
    Menu(iconData: Icons.card_giftcard, title: "Cadeaux", color: Colors.green),
    Menu(iconData: Icons.lock, title: "Coffre", color: Colors.pink),
    Menu(iconData: Icons.bus_alert_outlined, title: "Transport", color: Colors.orange),



  ];
}
