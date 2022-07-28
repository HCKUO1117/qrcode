
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qrcode/constants/constants.dart';

class AdBanner extends StatefulWidget {
  final bool large;
  const AdBanner({Key? key, required this.large}) : super(key: key);

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {

  final BannerAd myBanner = BannerAd(
    adUnitId: Constants.testingMode
        ? Constants.testBannerId
        : Constants.bannerId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  final BannerAd largeBanner = BannerAd(
    adUnitId: Constants.testingMode
        ? Constants.testBannerId
        : Constants.bannerId,
    size: AdSize.mediumRectangle,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void initState() {
    if(widget.large){
      largeBanner.load();
    }else{
      myBanner.load();
    }
    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var iap = Provider.of<IAP>(context);
    // if(iap.isSubscription == true){
    //   return const SizedBox();
    // }
    return SizedBox(
      height: widget.large ?250:50,
      child: AdWidget(ad: widget.large ? largeBanner:myBanner),
    );
  }
}