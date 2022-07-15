
class License {
  String? key;
  String? name;
  String? url;
  String? spdxId;
  String? nodeId;
  String? htmlUrl;

  License(
      {key, name, url, spdxId, nodeId, htmlUrl});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    url = json['url'];
    spdxId = json['spdx_id'];
    nodeId = json['node_id'];
    htmlUrl = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['url'] = url;
    data['spdx_id'] = spdxId;
    data['node_id'] = nodeId;
    data['html_url'] = htmlUrl;
    return data;
  }
}
