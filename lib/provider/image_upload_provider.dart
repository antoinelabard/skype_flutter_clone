import 'package:flutter/cupertino.dart';
import 'package:skype_flutter_clone/enum/view_state.dart';

class ImageUploadProvider with ChangeNotifier {
  var _viewState = ViewState.IDLE;

  get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }
}
