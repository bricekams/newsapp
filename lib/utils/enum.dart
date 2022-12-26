enum APIRequestStatus {
  unInitialized,
  loading,
  loadingMore,
  loaded,
  error,
  connectionError,
  searchLoading,
  searchLoaded,
  searchError,
  searchConnectionError,
}

extension APIRequestStatusExt on APIRequestStatus {
  String get asString => toString().split('.')[1];
  bool get isLoading => asString == "loading";
  bool get isLoadingMore => asString == "loadingMore";
  bool get isUninitialized => asString == "unInitialized";
  bool get isLoaded => asString == "loaded";
  bool get hasError => asString == "error";
  bool get hasConnectionError => asString == "connectionError";
  bool get isSearchLoading => asString == "searchLoading";
  bool get isSearchLoaded => asString == "searchLoaded";
  bool get hasSearchError => asString == "searchError";
  bool get hasSearchConnectionError => asString == "searchConnectionError";
}