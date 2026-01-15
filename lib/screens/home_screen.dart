import 'package:file_rouge_wave/model/Menu.dart';
import 'package:file_rouge_wave/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../utils/image_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = false;

  isShow() {
    setState(() {
      isVisible = !isVisible;
    });
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
                  print("Hello click!");
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                )),
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
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: isVisible ? "F" : "",
                                style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))
                          ]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                height: 2000,
                color: Colors.deepPurple,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      margin: const EdgeInsets.only(top: 80),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(ImageConstant.imgBg),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.blue.shade700,
                                          BlendMode.srcIn))),
                              height: 200,
                              width: 350,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: 160,
                                      width: 160,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 130,
                                            width: 130,
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            child: PrettyQrView.data(
                                              data:
                                                  'lorem ipsum dolor sit amet',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 20,
                                              ),
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
                                      ))
                                ],
                              )),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
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

                          )
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
