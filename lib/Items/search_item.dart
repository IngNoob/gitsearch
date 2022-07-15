
import 'package:gitsearch/Items/license.dart';
import 'package:gitsearch/Items/owner.dart';

class SearchItem {
  int? id;
  String? nodeId;
  String? name;
  String? fullName;
  Owner? owner;
  bool? private;
  String? htmlUrl;
  String? description;
  bool? fork;
  String? url;
  String? createdAt;
  String? updatedAt;
  String? pushedAt;
  String? homepage;
  int? size;
  int? stargazersCount;
  int? watchersCount;
  String? language;
  int? forksCount;
  int? openIssuesCount;
  String? masterBranch;
  String? defaultBranch;
  double? score;
  String? archiveUrl;
  String? assigneesUrl;
  String? blobsUrl;
  String? branchesUrl;
  String? collaboratorsUrl;
  String? commentsUrl;
  String? commitsUrl;
  String? compareUrl;
  String? contentsUrl;
  String? contributorsUrl;
  String? deploymentsUrl;
  String? downloadsUrl;
  String? eventsUrl;
  String? forksUrl;
  String? gitCommitsUrl;
  String? gitRefsUrl;
  String? gitTagsUrl;
  String? gitUrl;
  String? issueCommentUrl;
  String? issueEventsUrl;
  String? issuesUrl;
  String? keysUrl;
  String? labelsUrl;
  String? languagesUrl;
  String? mergesUrl;
  String? milestonesUrl;
  String? notificationsUrl;
  String? pullsUrl;
  String? releasesUrl;
  String? sshUrl;
  String? stargazersUrl;
  String? statusesUrl;
  String? subscribersUrl;
  String? subscriptionUrl;
  String? tagsUrl;
  String? teamsUrl;
  String? treesUrl;
  String? cloneUrl;
  String? mirrorUrl;
  String? hooksUrl;
  String? svnUrl;
  int? forks;
  int? openIssues;
  int? watchers;
  bool? hasIssues;
  bool? hasProjects;
  bool? hasPages;
  bool? hasWiki;
  bool? hasDownloads;
  bool? archived;
  bool? disabled;
  String? visibility;
  License? license;

  SearchItem(
      {id,
      nodeId,
      name,
      fullName,
      owner,
      private,
      htmlUrl,
      description,
      fork,
      url,
      createdAt,
      updatedAt,
      pushedAt,
      homepage,
      size,
      stargazersCount,
      watchersCount,
      language,
      forksCount,
      openIssuesCount,
      masterBranch,
      defaultBranch,
      score,
      archiveUrl,
      assigneesUrl,
      blobsUrl,
      branchesUrl,
      collaboratorsUrl,
      commentsUrl,
      commitsUrl,
      compareUrl,
      contentsUrl,
      contributorsUrl,
      deploymentsUrl,
      downloadsUrl,
      eventsUrl,
      forksUrl,
      gitCommitsUrl,
      gitRefsUrl,
      gitTagsUrl,
      gitUrl,
      issueCommentUrl,
      issueEventsUrl,
      issuesUrl,
      keysUrl,
      labelsUrl,
      languagesUrl,
      mergesUrl,
      milestonesUrl,
      notificationsUrl,
      pullsUrl,
      releasesUrl,
      sshUrl,
      stargazersUrl,
      statusesUrl,
      subscribersUrl,
      subscriptionUrl,
      tagsUrl,
      teamsUrl,
      treesUrl,
      cloneUrl,
      mirrorUrl,
      hooksUrl,
      svnUrl,
      forks,
      openIssues,
      watchers,
      hasIssues,
      hasProjects,
      hasPages,
      hasWiki,
      hasDownloads,
      archived,
      disabled,
      visibility,
      license});

  SearchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    private = json['private'];
    htmlUrl = json['html_url'];
    description = json['description'];
    fork = json['fork'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushedAt = json['pushed_at'];
    homepage = json['homepage'];
    size = json['size'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    language = json['language'];
    forksCount = json['forks_count'];
    openIssuesCount = json['open_issues_count'];
    masterBranch = json['master_branch'];
    defaultBranch = json['default_branch'];
    score = json['score'];
    archiveUrl = json['archive_url'];
    assigneesUrl = json['assignees_url'];
    blobsUrl = json['blobs_url'];
    branchesUrl = json['branches_url'];
    collaboratorsUrl = json['collaborators_url'];
    commentsUrl = json['comments_url'];
    commitsUrl = json['commits_url'];
    compareUrl = json['compare_url'];
    contentsUrl = json['contents_url'];
    contributorsUrl = json['contributors_url'];
    deploymentsUrl = json['deployments_url'];
    downloadsUrl = json['downloads_url'];
    eventsUrl = json['events_url'];
    forksUrl = json['forks_url'];
    gitCommitsUrl = json['git_commits_url'];
    gitRefsUrl = json['git_refs_url'];
    gitTagsUrl = json['git_tags_url'];
    gitUrl = json['git_url'];
    issueCommentUrl = json['issue_comment_url'];
    issueEventsUrl = json['issue_events_url'];
    issuesUrl = json['issues_url'];
    keysUrl = json['keys_url'];
    labelsUrl = json['labels_url'];
    languagesUrl = json['languages_url'];
    mergesUrl = json['merges_url'];
    milestonesUrl = json['milestones_url'];
    notificationsUrl = json['notifications_url'];
    pullsUrl = json['pulls_url'];
    releasesUrl = json['releases_url'];
    sshUrl = json['ssh_url'];
    stargazersUrl = json['stargazers_url'];
    statusesUrl = json['statuses_url'];
    subscribersUrl = json['subscribers_url'];
    subscriptionUrl = json['subscription_url'];
    tagsUrl = json['tags_url'];
    teamsUrl = json['teams_url'];
    treesUrl = json['trees_url'];
    cloneUrl = json['clone_url'];
    mirrorUrl = json['mirror_url'];
    hooksUrl = json['hooks_url'];
    svnUrl = json['svn_url'];
    forks = json['forks'];
    openIssues = json['open_issues'];
    watchers = json['watchers'];
    hasIssues = json['has_issues'];
    hasProjects = json['has_projects'];
    hasPages = json['has_pages'];
    hasWiki = json['has_wiki'];
    hasDownloads = json['has_downloads'];
    archived = json['archived'];
    disabled = json['disabled'];
    visibility = json['visibility'];
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['full_name'] = fullName;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['private'] = private;
    data['html_url'] = htmlUrl;
    data['description'] = description;
    data['fork'] = fork;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pushed_at'] = pushedAt;
    data['homepage'] = homepage;
    data['size'] = size;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    data['forks_count'] = forksCount;
    data['open_issues_count'] = openIssuesCount;
    data['master_branch'] = masterBranch;
    data['default_branch'] = defaultBranch;
    data['score'] = score;
    data['archive_url'] = archiveUrl;
    data['assignees_url'] = assigneesUrl;
    data['blobs_url'] = blobsUrl;
    data['branches_url'] = branchesUrl;
    data['collaborators_url'] = collaboratorsUrl;
    data['comments_url'] = commentsUrl;
    data['commits_url'] = commitsUrl;
    data['compare_url'] = compareUrl;
    data['contents_url'] = contentsUrl;
    data['contributors_url'] = contributorsUrl;
    data['deployments_url'] = deploymentsUrl;
    data['downloads_url'] = downloadsUrl;
    data['events_url'] = eventsUrl;
    data['forks_url'] = forksUrl;
    data['git_commits_url'] = gitCommitsUrl;
    data['git_refs_url'] = gitRefsUrl;
    data['git_tags_url'] = gitTagsUrl;
    data['git_url'] = gitUrl;
    data['issue_comment_url'] = issueCommentUrl;
    data['issue_events_url'] = issueEventsUrl;
    data['issues_url'] = issuesUrl;
    data['keys_url'] = keysUrl;
    data['labels_url'] = labelsUrl;
    data['languages_url'] = languagesUrl;
    data['merges_url'] = mergesUrl;
    data['milestones_url'] = milestonesUrl;
    data['notifications_url'] = notificationsUrl;
    data['pulls_url'] = pullsUrl;
    data['releases_url'] = releasesUrl;
    data['ssh_url'] = sshUrl;
    data['stargazers_url'] = stargazersUrl;
    data['statuses_url'] = statusesUrl;
    data['subscribers_url'] = subscribersUrl;
    data['subscription_url'] = subscriptionUrl;
    data['tags_url'] = tagsUrl;
    data['teams_url'] = teamsUrl;
    data['trees_url'] = treesUrl;
    data['clone_url'] = cloneUrl;
    data['mirror_url'] = mirrorUrl;
    data['hooks_url'] = hooksUrl;
    data['svn_url'] = svnUrl;
    data['forks'] = forks;
    data['open_issues'] = openIssues;
    data['watchers'] = watchers;
    data['has_issues'] = hasIssues;
    data['has_projects'] = hasProjects;
    data['has_pages'] = hasPages;
    data['has_wiki'] = hasWiki;
    data['has_downloads'] = hasDownloads;
    data['archived'] = archived;
    data['disabled'] = disabled;
    data['visibility'] = visibility;
    if (license != null) {
      data['license'] = license!.toJson();
    }
    return data;
  }
}
