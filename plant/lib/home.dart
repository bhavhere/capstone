import 'package:flutter/material.dart';
import 'package:plant/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

var message = {
  'Healthy': 'This plant is healthy',
  'Early Blight':
      '• Use fungicide sprays based on mandipropamid,chlorothalonil, fluazinam, mancozeb to combat late blight\n\n• Water in the early morning hours, or use soaker hoses, to give plants time to dry out during the day — avoid overhead irrigation.',
  'Late Blight':
      '• Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable.\n\n• A day after treatment, remove the lower branches with sharp razor blade knife. Clean your knife with rubbing alcohol before trimming the next plant to prevent the spread of the disease.\n • Do not spray pesticides, fungicides, fertilizers or herbicides when it’s in the high 80’s or 90; you can damage your plants. Water your plants the day before spraying, hydration is important!',
  'Early Blight':
      '• Fungicides with protectant and curative properties are used against early blight on potato. Protectant fungicides such as mancozeb and chlorothalonil areused as the foundation of most early blight management programs \n\n • These fungicides must be reapplied every 7-10 days to provide protection of new growth as well as to counter the effects of weathering which progressively removes the chemical from the leaf surface.',
  'Late Blight':
      '• Use systemic fungicides, such as dimethomorph, cymoxanil, fluopicolide and propamacarb. Continue fungicide applications at 7- to 10-day intervals as conditions require. Shorter intervals may be needed under cool, rainy conditions.\n\n • Late blight is controlled by eliminating cull piles and volunteer potatoes, using proper harvesting and storage practices, and applying fungicides when necessary.',
  'Bacterial Spots':
      '• Copper sprays can be used to control bacterial leaf spot, but they are not as effective when used alone on a continuous basis. Thus, combining these sprays with a plant resistance inducer, such as Regalia or Actigard, can provide good protection from the disease.\n\n • Beneficial microorganisms containing products, such as Serenade and Sonata, can reduce pepper leaf spot if used proactively'
};

enum ScreenState { SHOW_MAIN_SCREEN, LOADING, RESULT, FAILED }
int indexx = 0;
String classRes = "Keshav";
double confi;
List img = ['https://ibb.co/93YdkGf'];
List Classifier = [
  'https://capstoneplant.herokuapp.com/predict_potato/',
  'https://capstoneplant.herokuapp.com/predict_tomato/',
  'https://capstoneplant.herokuapp.com/predict_bell_pepper/'
];
String img_url = "Keshav Tanwar";

dynamic CURRENT_STATE = ScreenState.SHOW_MAIN_SCREEN;

File _image;
final picker = ImagePicker();
final cloudinary = CloudinaryPublic('dcfrtfm7i', 'tyztntnh', cache: false);

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Home(context, h, w) {
      return Scaffold(
        backgroundColor: kbackground,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(tag: "logo", child: Text('Plantas', style: ktitleSmall)),
                SizedBox(height: h * .025),
                Container(
                  decoration: ktoggleDec,
                  child: ToggleSwitch(
                    minWidth: 100.0,
                    minHeight: 50.0,
                    activeBgColor: [Color(0xff4FC8DA)],
                    initialLabelIndex: 0,
                    totalSwitches: 3,
                    labels: ['Potato', 'Pepper', 'Tomato'],
                    onToggle: (index) {
                      indexx = index;
                      print(indexx);
                      //setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: h * 0.60,
                  width: w * 0.80,
                  child: Column(
                    children: [
                      LottieBuilder.network(
                          'https://assets8.lottiefiles.com/private_files/lf30_fcotb6bb.json'),
                      Text(
                        'Detect Plant Diseases at Early Stages',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 50, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: kbackground,
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(
                  height: h * .03,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image =
                            await picker.getImage(source: ImageSource.camera);
                        setState(() {
                          CURRENT_STATE = ScreenState.LOADING;
                        });
                        try {
                          CloudinaryResponse response =
                              await cloudinary.uploadFile(
                            CloudinaryFile.fromFile(image.path,
                                resourceType: CloudinaryResourceType.Image),
                          );
                          img_url = response.secureUrl;
                          print(img_url);
                          print(Classifier[indexx]);
                        } on CloudinaryException catch (e) {
                          print(e.message);
                          print(e.request);
                          CURRENT_STATE = ScreenState.FAILED;
                        }
                        try {
                          var dio = Dio();
                          dynamic response1 = await dio
                              .post(Classifier[indexx], data: {"url": img_url});
                          print(response1.data);

                          classRes = response1.data['class'];
                          confi = response1.data['confidence'];
                          setState(() {
                            CURRENT_STATE = ScreenState.RESULT;
                          });
                        } catch (e) {
                          CURRENT_STATE = ScreenState.FAILED;
                        }
                        if (classRes == "Keshav") {
                          CURRENT_STATE = ScreenState.FAILED;
                          setState(() {});
                        }
                      },
                      child: Container(
                        child: Center(child: Text("Camera")),
                        width: w / 2,
                        height: h * .08,
                        decoration: const BoxDecoration(
                            color: Color(0xff3A6AD0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final image =
                            await picker.getImage(source: ImageSource.gallery);
                        setState(() {
                          CURRENT_STATE = ScreenState.LOADING;
                        });
                        try {
                          CloudinaryResponse response =
                              await cloudinary.uploadFile(
                            CloudinaryFile.fromFile(image.path,
                                resourceType: CloudinaryResourceType.Image),
                          );
                          img_url = response.secureUrl;
                          print(img_url);
                          print(Classifier[indexx]);
                        } on CloudinaryException catch (e) {
                          print(e.message);
                          print(e.request);
                          CURRENT_STATE = ScreenState.FAILED;
                        }
                        try {
                          var dio = Dio();
                          dynamic response1 = await dio
                              .post(Classifier[indexx], data: {"url": img_url});
                          print(response1.data);

                          classRes = response1.data['class'];
                          confi = response1.data['confidence'];
                          setState(() {
                            CURRENT_STATE = ScreenState.RESULT;
                          });
                        } catch (e) {
                          CURRENT_STATE = ScreenState.FAILED;
                        }
                        if (classRes == "Keshav") {
                          CURRENT_STATE = ScreenState.FAILED;
                          setState(() {});
                        }
                      },
                      child: Container(
                        child: Center(child: Text("Gallery")),
                        width: w / 2,
                        height: h * .08,
                        decoration: const BoxDecoration(
                            color: Color(0xff3A6AD0),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return CURRENT_STATE == ScreenState.SHOW_MAIN_SCREEN
        ? Home(context, h, w)
        : CURRENT_STATE == ScreenState.LOADING
            ? Loading(context)
            : Result(context);
  }
}

Loading(context) {
  return Scaffold(
    body: Container(
      child: Center(
        child: LottieBuilder.network(
            'https://assets1.lottiefiles.com/private_files/lf30_ykdoon9j.json'),
      ),
    ),
  );
}

Result(context) {
  return Scaffold(
    backgroundColor: kbackground,
    body: SafeArea(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Report",
                  style: ktitle,
                ),
                Container(),
                Text(
                  classRes,
                  style: GoogleFonts.mPlusRounded1c(fontSize: 30),
                ),
                Text(
                  "Likelyhood = ${(confi * 100).toString().substring(0, 4)}",
                  style: GoogleFonts.mPlusRounded1c(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .50,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  decoration: kcontainerDec,
                  child: Center(
                    child: Text(
                      message[classRes],
                      style: GoogleFonts.roboto(fontSize: 20),
                      //overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Expanded(child: Text('')),
                GestureDetector(
                  onTap: () {
                    CURRENT_STATE = ScreenState.SHOW_MAIN_SCREEN;
                    Navigator.pop(context);
                  },
                  child: Container(
                      child: Icon(Icons.home),
                      height: 70,
                      width: 70,
                      decoration: kcontainerDec),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    ),
  );
}

Failed(context) {
  return Scaffold(
    backgroundColor: kbackground,
    body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Text("An Error has Occured/n Please try again"),
            FloatingActionButton(
              onPressed: () {
                CURRENT_STATE = ScreenState.SHOW_MAIN_SCREEN;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Icon(Icons.arrow_back_ios_new_sharp),
            )
          ],
        ),
      ),
    ),
  );
}
