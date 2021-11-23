import 'package:bmi_calculator_praktikum_m/calculator_brain.dart';
import 'package:bmi_calculator_praktikum_m/components/bottom_button.dart';
import 'package:bmi_calculator_praktikum_m/components/round_button_icon.dart';
import 'package:bmi_calculator_praktikum_m/constant.dart';
import 'package:bmi_calculator_praktikum_m/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 30;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("BMI Calculator"), centerTitle: true),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: "MALE",
                  ),
                  colour: selectedGender == Gender.male
                      ? kActiveCardColor
                      : kInActiveCardColor,
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: "FEMALE",
                  ),
                  colour: selectedGender == Gender.female
                      ? kActiveCardColor
                      : kInActiveCardColor,
                ),
              )
            ],
          )),

          //Untuk Tinggi
          Expanded(
              child: ReusableCard(
            colour: kInActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TINGGI',
                  style: kLabelStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelStyle,
                    )
                  ],
                ),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderThumbShape(enabledThumbRadius: 30.0)),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ))
              ],
            ),
          )),

          //Untuk Berat dan Umur
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'BERAT',
                        style: kLabelStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundButtonIcon(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (weight > 30) weight--;
                                });
                              }),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundButtonIcon(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UMUR',
                        style: kLabelStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundButtonIcon(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (age > 1) age--;
                                });
                              }),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundButtonIcon(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),

          //Ini Tombol Untuk Menghitung (calculate)
          BottomButton(
              buttonText: "HITUNG",
              onTap: () {
                CalculatorBrain hitung =
                    CalculatorBrain(height: height, weight: weight);
                Navigator.pushNamed(context, ResultPage.routeName,
                    arguments: ResultPage(
                      bmiResult: hitung.calculateBmi(),
                      resultText: hitung.getResult(),
                      interpretation: hitung.getInterpretation(),
                    ));
              })
        ]));
  }
}
