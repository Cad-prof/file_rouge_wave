class Transaction {
  String title;
  int amount;
  DateTime date;
  TType type;
  final String category;

  Transaction(
      {required this.title,
        required this.amount,
        required this.date,
        required this.type,
        this.category = 'transfer'}
      );
  static List<Transaction> transactionList = [
    Transaction(
      title: "Mamadou Diallo",
      amount: 15000,
      date: DateTime(2026, 02, 10),
      type: TType.envoi,
    ),

    Transaction(
      title: "Parcelles",
      amount: 20000,
      date: DateTime(2026, 02, 11),
      type: TType.retrait,
    ),

    Transaction(
      title: "Agent - Liberté 6",
      amount: 50000,
      date: DateTime(2026, 02, 12),
      type: TType.depot,
    ),

    Transaction(
      title: "Paiement Senelec",
      amount: 12000,
      date: DateTime(2026, 02, 12),
      type: TType.paiement,
    ),

    Transaction(
      title: "Awa Ba",
      amount: 8000,
      date: DateTime(2026, 02, 13),
      type: TType.envoi,
    ),

    Transaction(
      title: "Paiement Canal+",
      amount: 18000,
      date: DateTime(2026, 02, 13),
      type: TType.paiement,
    ),

    Transaction(
      title: "Ouakam",
      amount: 10000,
      date: DateTime(2026, 02, 14),
      type: TType.retrait,
    ),

    Transaction(
      title: "Agent - Médina",
      amount: 30000,
      date: DateTime(2026, 02, 14),
      type: TType.depot,
    ),

    Transaction(
      title: "Paiement Frais Université",
      amount: 35000,
      date: DateTime(2026, 02, 15),
      type: TType.paiement,
    ),

    Transaction(
      title: "Fatou Ndiaye",
      amount: 22000,
      date: DateTime(2026, 02, 15),
      type: TType.envoi,
    ),

    Transaction(
      title: "Wave - Pikine",
      amount: 15000,
      date: DateTime(2026, 02, 16),
      type: TType.retrait,
    ),

    Transaction(
      title: "Paiement Marchand - Boutique Ali",
      amount: 7500,
      date: DateTime(2026, 02, 16),
      type: TType.paiement,
    ),

    Transaction(
      title: "Agent - Keur Massar",
      amount: 45000,
      date: DateTime(2026, 02, 17),
      type: TType.depot,
    ),

    Transaction(
      title: "Ousmane Sow",
      amount: 10000,
      date: DateTime(2026, 02, 17),
      type: TType.envoi,
    ),

    Transaction(
      title: "Paiement Eau",
      amount: 9000,
      date: DateTime(2026, 02, 18),
      type: TType.paiement,
    ),
  ];


}
enum TType{
  envoi,
  retrait,
  depot,
  paiement
}


