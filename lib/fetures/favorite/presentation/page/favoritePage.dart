import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/util/ScreenUtil.dart';
import 'package:myapp/core/widgets/Others/customErrorWidget.dart';
import 'package:myapp/core/widgets/Texts/primaryText.dart';
import 'package:myapp/fetures/favorite/presentation/manager/favorite_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../injection_container.dart';
import '../../../users/data/models/userModel.dart';
import '../widget/favoriteWidget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  ScreenUtil screenUtil = ScreenUtil();
  UserModel? user;
  @override
  void initState() {
    checkUserLoggedIn().fold((l) {
      user = l;
    }, (r) {
      user = null;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: BlocProvider(
        create: (context) => sl<FavoriteBloc>(),
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (_context, state) {},
          builder: (_context, state) {
            if (state is FavoriteInitial) {
              BlocProvider.of<FavoriteBloc>(_context)
                  .add(GetUserFavorite(token: user?.token ?? ''));
            }

            if (state is FavoriteLoading) {
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 22 / 30,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.04),
                      highlightColor:
                      AppTheme.scaffoldBackgroundColor.withOpacity(.1),
                      enabled: true,
                      child: Container(
                        height: screenUtil.screenHeight * .2,
                        width: screenUtil.screenWidth * .4,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    );

                  });
            }

            if(state is FavoriteLoaded){
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.model.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 22 / 30,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return FavoriteWidget(
                      name: state.model[index].name,
                      image: state.model[index].image,
                    );
                  });
            }

            if(state is FavoriteError){
              return Center(
                child: CustomErrorWidget(
                  message: state.errorMessage,
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
