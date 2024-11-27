import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcast/api/api_repo.dart';
import 'package:weather_forcast/features/home/model/forecast_model.dart';
import 'package:weather_forcast/features/home/model/future_model.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../core/app_strings.dart';
import '../../../core/app_text_style.dart';
import '../../../generated/assets.dart';

class DetailPageView extends StatelessWidget {
  String cityName;
  ForecastModel forecastModel;

  DetailPageView(
      {super.key, required this.cityName, required this.forecastModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityName,
            style: AppTextStyle.s30w500,
          ),
          const Divider(),
          Row(
            children: [
              Text(
                '${forecastModel.current!.condition!.text}',
                style: AppTextStyle.s18w500.copyWith(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.5)),
              ),
              Image.network("https:${forecastModel.current!.condition!.icon}"),
            ],
          ),
          TextAnimator(
            '${forecastModel.current!.tempC}°c',
            atRestEffect: WidgetRestingEffects.pulse(),
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                duration: const Duration(seconds: 1)),
            style: AppTextStyle.s120w500,
          ),
          Row(
            children: [
              Text(AppStrings.details),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppStrings.appLink,
                  style: AppTextStyle.s10w500.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              details(context,
                  title: AppStrings.wind,
                  icon: Assets.imagesWind,
                  description: "${forecastModel.current!.windKph}",
                  format: AppStrings.km),
              details(context,
                  title: AppStrings.humidity,
                  icon: Assets.imagesHumidity,
                  description: "${forecastModel.current!.humidity}",
                  format: '%'),
              details(context,
                  title: AppStrings.uv,
                  icon: Assets.imagesUv,
                  description: "${forecastModel.current!.uv}",
                  format: ''),
              details(context,
                  title: AppStrings.pressure,
                  icon: Assets.imagesPressure,
                  description: "${forecastModel.current!.pressureMb}",
                  format: AppStrings.hpa),
            ],
          ),
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return FutureBuilder(
                    future: ApiRepo.getFutureForecasting(
                        cityName, DateTime.now().add(Duration(days: 15 + i))),
                    builder: (context, snapShot) {
                      if (snapShot.hasData == false) {
                        return const SizedBox(
                          child: SizedBox(),
                        );
                      }
                      FutureModel model =
                          FutureModel.fromJson(jsonDecode(snapShot.data));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                  "https:${model.forecast!.forecastday!.first.day!.condition!.icon}"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('dd, MMM yyyy').format(
                                        DateTime.now()
                                            .add(Duration(days: 15 + i))),
                                    style: AppTextStyle.s18w500,
                                  ),
                                  Text(
                                    model.forecast!.forecastday!.first.day!
                                            .condition!.text ??
                                        "",
                                    style: AppTextStyle.s13w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                              "Max temp : ${model.forecast!.forecastday!.first.day!.maxtempC}"),
                          Text(
                              "Min temp : ${model.forecast!.forecastday!.first.day!.mintempC}"),
                          const Divider()
                        ],
                      );
                    });
              })
        ],
      ),
    );
  }

  Widget details(context,
      {required String title,
      required String icon,
      required String description,
      required String format}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                height: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: AppTextStyle.s18w500.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(
                style: AppTextStyle.s30w500.copyWith(
                  // color: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
              TextSpan(text: '$description '),
              TextSpan(
                  text: format,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.5),
                      fontWeight: FontWeight.w300))
            ])),
      ],
    );
  }
}
