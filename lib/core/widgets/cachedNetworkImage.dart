import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../dataProviders/network/data_source_url.dart';
import 'Others/customLoadingProgressIndicator.dart';


CachedNetworkImage cachedNetworkImage({required String image,width=null,height=null,onFailed,fit=BoxFit.fill}) {
  return CachedNetworkImage(
      fit: fit,
      // imageUrl: DataSourceURL.baseUrl + imagePath + image,
      imageUrl: DataSourceURL.baseImagesUrl + image,
      //
      placeholder: (context, url) => Center(
              child: CustomLoadingProgressIndicator()
      ),
      errorWidget: (context, url, error) {
          if(onFailed!=null)  onFailed();
        return Center(
            child: Image.asset(
          "assets/images/background2.jpg",
          fit: BoxFit.cover,
          height: height ?? double.infinity,
          width: width ?? double.infinity,
        ));
      });
}

