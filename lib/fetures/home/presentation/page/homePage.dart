import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/util/ScreenUtil.dart';
import 'package:myapp/core/widgets/Texts/primaryText.dart';
import 'package:myapp/fetures/home/presentation/manager/home_bloc.dart';
import 'package:myapp/fetures/home/presentation/widget/groupsWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/Others/customErrorWidget.dart';
import '../../../../injection_container.dart';
import '../widget/SliderWidget.dart';
import '../widget/mostRatedGroupsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderWidget(imagesPaths: images),
              SizedBox(
                height: 20,
              ),
              PrimaryText(
                text: 'المدن والجزر',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => sl<HomeBloc>(),
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (_context, state) {},
                  builder: (_context, state) {
                    if (state is HomeInitial) {
                      BlocProvider.of<HomeBloc>(_context).add(GetHomeGroups());
                    }

                    if (state is HomeLoading) {
                      return SizedBox(
                        height: screenUtil.screenHeight * .15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(0.04),
                                highlightColor: AppTheme.scaffoldBackgroundColor
                                    .withOpacity(.1),
                                enabled: true,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: screenUtil.screenHeight * .15,
                                  width: screenUtil.screenWidth * .3,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                            }),
                      );
                    }

                    if (state is HomeLoaded) {
                      return SizedBox(
                        height: screenUtil.screenHeight * .15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: state.model.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return GroupWidget(
                                image: state.model[index].image,
                                name: state.model[index].name,
                              );
                            }),
                      );
                    }

                    if (state is HomeError) {
                      return Center(
                        child: CustomErrorWidget(
                          message: state.errrosMessage,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              PrimaryText(
                text: 'الأكثر تقييما',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => sl<HomeBloc>(),
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (_context, state) {},
                  builder: (_context, state) {
                    if (state is HomeInitial) {
                      BlocProvider.of<HomeBloc>(_context)
                          .add(GetHomeMostRatedGroups());
                    }

                    if (state is HomeLoading) {
                      return SizedBox(
                        height: screenUtil.screenHeight * .15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(0.04),
                                highlightColor: AppTheme.scaffoldBackgroundColor
                                    .withOpacity(.1),
                                enabled: true,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: screenUtil.screenHeight * .15,
                                  width: screenUtil.screenWidth * .3,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                            }),
                      );
                    }

                    if (state is HomeLoaded) {
                      return SizedBox(
                        height: screenUtil.screenHeight * .2,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: state.model.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return MostRatedGroupWidget(
                                image: state.model[index].image,
                                name: state.model[index].name,
                                rate: state.model[index].rate as double,
                              );
                            }),
                      );
                    }

                    if (state is HomeError) {
                      return Center(
                        child: CustomErrorWidget(
                          message: state.errrosMessage,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
