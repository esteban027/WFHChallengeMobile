abstract class PageEvent {
  void setPage(int page);
}

class BasicPageEvent extends PageEvent {
  int page;
  BasicPageEvent(this.page);
  @override
  void setPage(int page) {
    this.page = page;
  }
}

class ReturnToInitialState extends BasicPageEvent {
  ReturnToInitialState() : super(1);
}
