import 'package:calculator/utils/color_scheme.dart';
import 'package:calculator/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({Key? key}) : super(key: key);

  final displayText = ValueNotifier<String>('');
  final ValueNotifier<ScreenMode> screenMode = ValueNotifier(ScreenMode.dark);

  onClick(String btnText, BuildContext context) {
    if (displayText.value.length > 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Number limit exceeded!'),
        ),
      );
      return;
    }
    if (btnText == 'c') {
      displayText.value = '';
    } else if (btnText == '1' ||
        btnText == '2' ||
        btnText == '3' ||
        btnText == '4' ||
        btnText == '5' ||
        btnText == '6' ||
        btnText == '7' ||
        btnText == '8' ||
        btnText == '9' ||
        btnText == '0' ||
        btnText == '+' ||
        btnText == '-' ||
        btnText == '*' ||
        btnText == '/' ||
        btnText == '%' ||
        btnText == '.') {
      displayText.value = displayText.value + btnText;
    } else if (btnText == '( )') {
      if (displayText.value.contains('(')) {
        displayText.value = displayText.value + ')';
      } else {
        displayText.value = displayText.value + '(';
      }
    } else {
      return;
    }
  }

  // calculate(String expression) {
  //   List<String> numbers = [];
  //   try {
  //     if (expression.contains('+')) {
  //       numbers = expression.split('+');
  //       displayText.value =
  //           (num.parse((numbers[0])) + num.parse((numbers[1]))).toString();
  //     } else if (expression.contains('-')) {
  //       numbers = expression.split('-');
  //       displayText.value =
  //           (num.parse((numbers[0])) - num.parse((numbers[1]))).toString();
  //     } else if (expression.contains('*')) {
  //       numbers = expression.split('*');
  //       displayText.value =
  //           (num.parse((numbers[0])) * num.parse((numbers[1]))).toString();
  //     } else if (expression.contains('/')) {
  //       numbers = expression.split('/');
  //       displayText.value =
  //           (num.parse((numbers[0])) / num.parse((numbers[1]))).toString();
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     displayText.value = 'Format error';
  //   }
  // }

  calculateExpressions(String exp) {
    try {
      num result = exp.replaceAll('%', '*0.01*').interpret();
      displayText.value =
          (result % 1) == 0 ? result.toInt().toString() : result.toString();
    } catch (e) {
      displayText.value = 'Format error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: screenMode,
          builder: (context, _, __) {
            return SafeArea(
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: displayText,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            width: size.width,
                            height: size.height * 0.35,
                            color: screenMode.value == ScreenMode.light
                                ? LightColorScheme.containerColor
                                : DarkColorScheme.containerColor,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                displayText.value,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: screenMode.value == ScreenMode.light
                                      ? LightColorScheme.txtColor
                                      : DarkColorScheme.txtColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    screenMode.value == ScreenMode.light
                                        ? screenMode.value = ScreenMode.dark
                                        : screenMode.value = ScreenMode.light;
                                  },
                                  icon: Icon(
                                    screenMode.value == ScreenMode.dark
                                        ? Icons.wb_sunny
                                        : Icons.nightlight,
                                    color: Colors.yellow[700],
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: screenMode.value == ScreenMode.light
                          ? LightColorScheme.btnContainerColor
                          : DarkColorScheme.btnContainerColor,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 9,
                          mainAxisSpacing: 9,
                        ),
                        children: [
                          CalcButton(
                            onBtnClick: () {
                              displayText.value = '';
                            },
                            btnText: 'C',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('( )', context),
                            btnText: '( )',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () {
                              if (displayText.value.isNotEmpty) {
                                displayText.value = displayText.value
                                    .substring(0, displayText.value.length - 1);
                              }
                            },
                            btnText: 'DEL',
                            txtColor: Colors.red,
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('/', context),
                            btnText: '/',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('7', context),
                            btnText: '7',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('8', context),
                            btnText: '8',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('9', context),
                            btnText: '9',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('*', context),
                            btnText: '*',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('4', context),
                            btnText: '4',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('5', context),
                            btnText: '5',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('6', context),
                            btnText: '6',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('+', context),
                            btnText: '+',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('1', context),
                            btnText: '1',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('2', context),
                            btnText: '2',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('3', context),
                            btnText: '3',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('-', context),
                            btnText: '-',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('%', context),
                            btnText: '%',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('0', context),
                            btnText: '0',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () => onClick('.', context),
                            btnText: '.',
                            screenMode: screenMode,
                          ),
                          CalcButton(
                            onBtnClick: () {
                              if (displayText.value.isNotEmpty) {
                                calculateExpressions(displayText.value);
                              }
                            },
                            btnText: '=',
                            btnColor: Colors.green,
                            txtColor: Colors.white,
                            screenMode: screenMode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CalcButton extends StatelessWidget {
  const CalcButton({
    Key? key,
    required this.onBtnClick,
    required this.btnText,
    this.btnColor,
    this.txtColor,
    required this.screenMode,
  }) : super(key: key);

  final Function() onBtnClick;
  final String btnText;
  final Color? btnColor;
  final Color? txtColor;
  final ValueNotifier<ScreenMode> screenMode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onBtnClick,
      child: CircleAvatar(
        radius: size.width * 0.05,
        backgroundColor: btnColor ??
            (screenMode.value == ScreenMode.light
                ? LightColorScheme.btnColor
                : DarkColorScheme.btnColor),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 24,
            color: txtColor ??
                (screenMode.value == ScreenMode.light
                    ? LightColorScheme.txtColor
                    : DarkColorScheme.txtColor),
          ),
        ),
      ),
    );
  }
}
