import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forcast/core/app_strings.dart';
import 'package:weather_forcast/core/app_text_style.dart';

import '../bloc/search_bloc.dart';
import '../model/places_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.searchCity),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocProvider(
          create: (context) => SearchBloc(),
          child: BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (bloc, state) {
              return Column(
                children: [
                  CupertinoSearchTextField(
                    controller: bloc.read<SearchBloc>().searchController,
                    onChanged: (v) {
                      bloc.read<SearchBloc>().add(SearchPlaceEvent());
                    },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, i) => const Divider(),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: bloc
                                  .read<SearchBloc>()
                                  .placesModel
                                  ?.places
                                  ?.length ??
                              0,
                          itemBuilder: (context, i) {
                            Places places = bloc
                                    .read<SearchBloc>()
                                    .placesModel
                                    ?.places?[i] ??
                                Places();
                            return InkWell(
                              onTap: (){
                                Navigator.pop(context,places);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      places.name ?? "",
                                      style: AppTextStyle.s18w500,
                                    ),
                                    Text(
                                      places.url ?? "",
                                      style: AppTextStyle.s10w500,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
