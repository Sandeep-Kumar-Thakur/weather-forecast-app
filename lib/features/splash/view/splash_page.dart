
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forcast/application.dart';
import 'package:weather_forcast/core/app_route.dart';
import 'package:weather_forcast/core/app_text_style.dart';
import 'package:weather_forcast/generated/assets.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashBloc()..add(CanNavigateEvent()),
        child: Center(
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if(state is NavigateState){
                Navigator.pushReplacementNamed(context, AppRoute.home,);
              }
              // TODO: implement listener
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetAnimator(
                    incomingEffect:
                    WidgetTransitionEffects.incomingOffsetThenScale(),
                    atRestEffect: WidgetRestingEffects.swing(numberOfPlays: 1),
                    outgoingEffect:
                    WidgetTransitionEffects.outgoingOffsetThenScale(),
                    child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Hero(
                            tag: 'appIcon',
                            child: Image.asset(Assets.imagesAppIcon)))),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextAnimator(Application.appName,
                      style: AppTextStyle.s25w500,
                      incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromLeft(),
                      atRestEffect: WidgetRestingEffects.bounce(
                          numberOfPlays: 1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
