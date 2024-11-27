import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forcast/application.dart';
import 'package:weather_forcast/core/app_route.dart';
import 'package:weather_forcast/core/app_strings.dart';
import 'package:weather_forcast/features/home/view/no_connection_view.dart';
import 'package:weather_forcast/features/search/model/places_model.dart';
import 'package:weather_forcast/generated/assets.dart';

import '../bloc/home_bloc.dart';
import '../model/forecast_model.dart';
import 'detail_page_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => HomeBloc()..add(GetLocationEvent()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(Application.appName),
            leading: Hero(
                tag: 'appIcon',
                child: Material(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(Assets.imagesAppIcon,),
                ))),
            actions: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (bloc, state) {
                  return IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.search).then((v) {
                          if (v != null) {
                            bloc.read<HomeBloc>().placesModel = v as Places?;
                            bloc.read<HomeBloc>().add(UpdateCityEvent());
                          }
                        });
                      },
                      icon: const Icon(Icons.search));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              buildWhen: (context, state) {
                return (state is LocationFetched ||
                    state is NoConnection ||
                    state is HaveConnection);
              },
              builder: (bloc, state) {
                if (state is HomeInitial ||
                    (state is HaveConnection &&
                        bloc.read<HomeBloc>().forecastModel == null)) {
                  return Text(AppStrings.fetchingData);
                }
                if (state is NoConnection) {
                  return const NoConnectionView();
                }
                return DetailPageView(
                  cityName: bloc.read<HomeBloc>().cityName ?? "",
                  forecastModel:
                      bloc.read<HomeBloc>().forecastModel ?? ForecastModel(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
