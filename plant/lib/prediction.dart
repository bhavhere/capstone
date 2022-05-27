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
  'Early Blight1':
      '• Use fungicide sprays based on mandipropamid,chlorothalonil, fluazinam, mancozeb to combat late blight\n\n• Water in the early morning hours, or use soaker hoses, to give plants time to dry out during the day — avoid overhead irrigation.',
  'Late Blight1':
      '• Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable.\n\n• A day after treatment, remove the lower branches with sharp razor blade knife. Clean your knife with rubbing alcohol before trimming the next plant to prevent the spread of the disease.\n\n • Do not spray pesticides, fungicides, fertilizers or herbicides when it’s in the high 80’s or 90; you can damage your plants. Water your plants the day before spraying, hydration is important!',
  'Early Blight0':
      '• Fungicides with protectant and curative properties are used against early blight on potato. Protectant fungicides such as mancozeb and chlorothalonil areused as the foundation of most early blight management programs \n\n • These fungicides must be reapplied every 7-10 days to provide protection of new growth as well as to counter the effects of weathering which progressively removes the chemical from the leaf surface.',
  'Late Blight0':
      '• Use systemic fungicides, such as dimethomorph, cymoxanil, fluopicolide and propamacarb. Continue fungicide applications at 7- to 10-day intervals as conditions require. Shorter intervals may be needed under cool, rainy conditions.\n\n • Late blight is controlled by eliminating cull piles and volunteer potatoes, using proper harvesting and storage practices, and applying fungicides when necessary.',
  'Bacterial Spot2':
      '• Copper sprays can be used to control bacterial leaf spot, but they are not as effective when used alone on a continuous basis. Thus, combining these sprays with a plant resistance inducer, such as Regalia or Actigard, can provide good protection from the disease.\n\n • Beneficial microorganisms containing products, such as Serenade and Sonata, can reduce pepper leaf spot if used proactively'
};

enum ScreenState { SHOW_MAIN_SCREEN, LOADING, RESULT, FAILED }
int indexx = 0;
String classRes = "Keshav";
double confi;

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
