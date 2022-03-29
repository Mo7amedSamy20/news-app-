class NewsState{}

class NewsIntialState extends NewsState{}

class ChangeAppNavBar extends NewsState{}

class GetLoadingBusiness extends NewsState{}

class GetdataSuccesBusiness extends NewsState{}

class GetdataErroeBusiness extends NewsState{

  final String error;

  GetdataErroeBusiness(this.error);

}
class GetLoadingSports extends NewsState{}

class GetdataSuccesSports extends NewsState{}

class GetdataErroeSports extends NewsState {

  final String error;

  GetdataErroeSports(this.error);
}
class GetLoadingScienceState extends NewsState{}

class GetdataSuccesScienceState extends NewsState{}

class GetdataErroeScienceState extends NewsState {

  final String error;

  GetdataErroeScienceState(this.error);
}

class GetLoadingSearchState extends NewsState{}

class GetdataSuccesSearchState extends NewsState{}

class GetdataErroeSearchState extends NewsState {

  final String error;

  GetdataErroeSearchState(this.error);
}