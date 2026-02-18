import 'package:file_rouge_wave/model/Menu.dart';
import 'package:file_rouge_wave/screens/scan_screen.dart';
import 'package:file_rouge_wave/screens/setting_screen.dart';
import 'package:file_rouge_wave/screens/transaction_screen.dart';
import 'package:file_rouge_wave/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../model/transaction.dart';
import '../utils/image_constant.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = false;
  String selectedFilter = 'Transfers';
  String searchQuery = '';

  isShow() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  // Méthode pour la recherche
  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  initJiffy() async {
    await Jiffy.setLocale('fr_ca');
  }

  @override
  void initState() {
    super.initState();
    initJiffy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                )
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: InkWell(
                onTap: () {
                  isShow();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: isVisible ? "10.000" : "••••••",
                          style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600
                          ),
                          children: [
                            TextSpan(
                                text: isVisible ? "F" : "",
                                style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                )
                            )
                          ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      !isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              centerTitle: true,
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.deepPurple,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Carte QR Code
                  CardWidget(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ScanScreen()),
                              (route) => true
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(ImageConstant.imgBg),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.blue.shade700,
                                    BlendMode.srcIn
                                )
                            )
                        ),
                        height: 200,
                        width: 350,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                height: 160,
                                width: 160,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 130,
                                      margin: const EdgeInsets.only(top: 5, left: 10),
                                      child: PrettyQrView.data(
                                        data: 'lorem ipsum dolor sit amet',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.camera_alt, size: 20),
                                        SizedBox(width: 5),
                                        Text('Scanner')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  ImageConstant.imgLogo,
                                  width: 60,
                                )
                            )
                          ],
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Container blanc avec contenu
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        )
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // GridView Menu
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4
                          ),
                          shrinkWrap: true,
                          itemCount: Menu.list.length,
                          itemBuilder: (BuildContext context, int index) {
                            Menu m = Menu.list[index];
                            return MenuWidget(
                                iconData: m.iconData,
                                color: m.color,
                                title: m.title
                            );
                          },
                        ),
                        Divider(
                          thickness: 5,
                          color: Colors.grey.withOpacity(.2),
                        ),
                        // Liste des transactions (10 max)
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: Transaction.transactionList.length > 10
                                ? 10
                                : Transaction.transactionList.length,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Transaction t = Transaction.transactionList[index];
                              bool isPlus = t.type == TType.depot || t.type == TType.retrait;
                              return Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${t.type == TType.retrait ? 'De ' : t.type == TType.envoi ? 'A ' : ''}${t.title}',
                                                style: GoogleFonts.dmSans(
                                                    color: Colors.deepPurple,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600
                                                )
                                            ),
                                            Text(
                                                '${isPlus ? '' : '-'}${t.amount}F',
                                                style: GoogleFonts.dmSans(
                                                    color: Colors.deepPurple,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600
                                                )
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        Jiffy.parseFromDateTime(t.date).format(
                                            pattern: 'dd/MM/yyyy hh:mm a'
                                        ),
                                        style: GoogleFonts.dmSans(color: Colors.grey),
                                      )
                                    ]
                                ),
                              );
                            }
                        ),
                        // Barre de recherche après les transactions
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TransactionScreen()
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8E6F5),  // Violet clair
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.deepPurple,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Rechercher',
                                      style: GoogleFonts.dmSans(
                                        color: Colors.deepPurple,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}