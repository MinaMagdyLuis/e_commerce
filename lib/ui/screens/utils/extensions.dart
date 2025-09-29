import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

extension ConnectivityExtension on Connectivity {
  Future<bool> get isInternetConnected async {
    List<ConnectivityResult> result = await checkConnectivity();

    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile);
  }
}

extension ScreenPercentage on num{

  double h(BuildContext context){
    return (this/MediaQuery.of(context).size.height)*100;
  }

  double w(BuildContext context){
    return (this/MediaQuery.of(context).size.width)*100;
  }
}