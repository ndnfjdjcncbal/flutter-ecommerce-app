class Searchhistory {
  String? historysearchId;
  String? historysearchName;
  String? historysearchNamear;
  String? historysearchSearch;
  String? usersearchUser;
  String? historysearchItemid;

  Searchhistory(
      {this.historysearchId,
        this.historysearchName,
        this.historysearchNamear,
        this.historysearchSearch,
        this.usersearchUser,
        this.historysearchItemid});

  Searchhistory.fromJson(Map<String, dynamic> json) {
    historysearchId = json['historysearch_id'];
    historysearchName = json['historysearch_name'];
    historysearchNamear = json['historysearch_namear'];
    historysearchSearch = json['historysearch_search'];
    usersearchUser = json['usersearch_user'];
    historysearchItemid = json['historysearch_itemid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['historysearch_id'] = this.historysearchId;
    data['historysearch_name'] = this.historysearchName;
    data['historysearch_namear'] = this.historysearchNamear;
    data['historysearch_search'] = this.historysearchSearch;
    data['usersearch_user'] = this.usersearchUser;
    data['historysearch_itemid'] = this.historysearchItemid;
    return data;
  }
}