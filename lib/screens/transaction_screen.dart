import 'package:file_rouge_wave/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selectedFilter = 'Transferts';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    initJiffy();
  }

  initJiffy() async {
    await Jiffy.setLocale('fr');
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  List<Transaction> getFilteredTransactions() {
    return Transaction.transactionList.where((t) {
      // Filtre par recherche
      if (searchQuery.isNotEmpty &&
          !t.title.toLowerCase().contains(searchQuery)) {
        return false;
      }
      // Ajoute ici la logique de filtre par catégorie si nécessaire
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = getFilteredTransactions();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transactions',
          style: GoogleFonts.dmSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher',
                hintStyle: GoogleFonts.dmSans(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
              ),
              onChanged: onSearchChanged,
            ),
          ),

          // Filtres par catégorie
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    icon: Icons.person,
                    label: 'Transferts',
                    isSelected: selectedFilter == 'Transferts',
                    onTap: () => setFilter('Transferts'),
                  ),
                  SizedBox(width: 8),
                  _buildFilterChip(
                    icon: Icons.lightbulb_outline,
                    label: 'Factures',
                    isSelected: selectedFilter == 'Factures',
                    onTap: () => setFilter('Factures'),
                  ),
                  SizedBox(width: 8),
                  _buildFilterChip(
                    icon: Icons.account_balance_wallet,
                    label: 'Coffre',
                    isSelected: selectedFilter == 'Coffre',
                    onTap: () => setFilter('Coffre'),
                  ),
                  SizedBox(width: 8),
                  _buildFilterChip(
                    icon: Icons.credit_card,
                    label: 'Carte',
                    isSelected: selectedFilter == 'Carte',
                    onTap: () => setFilter('Carte'),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),

          // Liste des transactions
          Expanded(
            child: filteredTransactions.isEmpty
                ? Center(
              child: Text(
                'Aucune transaction trouvée',
                style: GoogleFonts.dmSans(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                Transaction t = filteredTransactions[index];
                bool isPlus =
                    t.type == TType.depot || t.type == TType.retrait;

                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${t.type == TType.retrait ? 'Retrait' : t.type == TType.envoi ? 'De ' : t.type == TType.depot ? 'De ' : ''}${t.type == TType.retrait ? '' : t.title}',
                              style: GoogleFonts.dmSans(
                                color: Colors.deepPurple,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              Jiffy.parseFromDateTime(t.date).format(
                                pattern: 'd MMM., HH:mm',
                              ),
                              style: GoogleFonts.dmSans(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${isPlus ? '+' : '-'}${t.amount.toStringAsFixed(0)}F',
                        style: GoogleFonts.dmSans(
                          color: isPlus ? Colors.green : Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.dmSans(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}