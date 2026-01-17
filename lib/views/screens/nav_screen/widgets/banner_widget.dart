import 'package:flutter/material.dart';

import '../../../../controllers/banner_controller.dart';
import '../../../../models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FutureBuilder(future: futureBanners, builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text('No Banners'),);
          }else {
            final banners = snapshot.data!;
            return Expanded(
              child: PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          }

        })
      );
  }
}
