import 'package:flutter/cupertino.dart';
import 'package:skype_flutter_clone/enum/view_state.dart';

/// Holds and fetch the information about the state of the app concerning the
/// media messages, that is to say if the app is currently loading a media
/// message, or if it's idle regarding the task.
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
