import 'package:flutter_riverpod/legacy.dart';
import 'package:shop_app/models/banner_model.dart';

class BannerProvider extends StateNotifier<List<BannerModel>>{
  BannerProvider() : super([]);

  void setBanner(List<BannerModel> banners) {
    state = banners;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider,List<BannerModel>>((ref){
  return BannerProvider();
});