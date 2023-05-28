import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/help_support_controller.dart';
import 'package:get/get.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  HelpSupportView({Key? key}) : super(key: key);

  final List<String> imageList = [
    'assets/images/kredit69.jpg',
    'assets/images/gedungbprwm.JPG',
    'assets/images/karyawanbpr.jpg',
    'assets/images/pegawai.jpg',
  ];

  final RxInt _currentIndex = 0.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aplikasi'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstants.background,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                _currentIndex.value = index; // Update the value of RxInt
              },
            ),
            items: imageList.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Obx(() =>
              DotsIndicator(
                dotsCount: imageList.length,
                position: _currentIndex.value.toDouble().toInt(),
                decorator: DotsDecorator(
                  activeColor: ColorConstants.buttonLogout,
                  size: Size(10.0, 10.0),
                  activeSize: Size(18.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )),
          SizedBox(height: 20),
          Text(
            'Profile BPR Weleri Makmur',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'BPR WM adalah sebuah lembaga keuangan bank yang telah berpengalaman selama 33 tahun, dan senantiasa berkembang dengan total aset lebih dari 500 Milyar. BPR WM berizin dan diawasi oleh Otoritas Jasa Keuangan dan menjadi anggota Lembaga Penjamin Simpanan (LPS) karena keamanan nasabah adalah prioritas utama.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Menangkan Hati Nasabah menjadi pedoman BPR WM dalam melayani nasabah. Dalam upaya memberikan pelayanan terbaik, kami membuka jaringan Kantor Cabang dan Kas yang tersebar di penjuru wilayah Jawa Tengah dan juga membuka pelayanan berbasis online, sehingga mampu memberikan pelayanan yang maksimal bagi nasabah.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Dengan dibuatnya aplikasi presensi karyawan BPR Weleri Makmur (AWM) diharapkan dapat mengatasi masalah yang selama ini terjadi dan mampu meningkatkan kinerja karyawan.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                _launchTelegram();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.buttonLogout,
              ),
              child: Text('Hubungi Kami'),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _launchTelegram() async {
    final phoneNumber = '+6281238753047'; // Ganti dengan nomor telepon yang valid
    final username = 'fyyy'; // Ganti dengan username yang valid

    final url = 'https://t.me/$username'; // Jika menggunakan username

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka Telegram';
    }
  }
}