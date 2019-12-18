#!/bin/bash

# Says hello
hello () {
    echo "Hello you!!! Have a good day!"
}

# Creates a new derectory and goes inside
mkd() {
    mkdir -p "$1";
    cd "$1"
}

# Utility method to url encode a string
urlencode() {
    python -c 'import urllib, sys; print urllib.quote(sys.argv[1], sys.argv[2])' "$1" "$urlencode_safe"
}

# Utility method to url decode a string
urldecode() {
    python -c 'import urllib, sys; print urllib.unquote(sys.argv[1])' "$1"
}

# ---------------------------------------------
# JIRA HELPER FUNCTIONS
# ---------------------------------------------
_jr-check() {
    if [ -z "$JIRA_URL" ] || [ -z "$JIRA_USER" ] || [ -z "$JIRA_PWD" ]; then
        echo "Calls to JIRA API require JIRA_URL, JIRA_USER and JIRA_PWD environment variable."
        return 1;
    fi
    return 0
}

jr-sh() {
    _jr-check
    if [ $? -ne 0 ]; then
        return 1
    fi

    jira_json="{ key: .key, url: (\"$JIRA_URL/browse/\" + .key), name: .fields.summary, status: .fields.status.name, desc: .fields.description }"
    json_src=$(curl -s "$JIRA_URL"/rest/api/latest/issue/"$1" -u "$JIRA_USER":"$JIRA_PWD")
    echo "$json_src" | jq "$jira_json"
}

jr-search() {
    _jr-check
    if [ $? -ne 0 ]; then
        return 1
    fi

    jql=$(urlencode "$1")

    jira_json="{ url: (\"$JIRA_URL/browse/\" + .key), name: .fields.summary, status: .fields.status.name }"
    jira_max_res=20

    json_src=$(curl -s "$JIRA_URL/rest/api/latest/search?jql=$jql&maxResults=$jira_max_res" -u "$JIRA_USER":"$JIRA_PWD")
    json_target=".issues[] | $jira_json"
    total=$(echo "$json_src" | jq ".total")

    echo "$json_src" | jq "$json_target"
    echo "Total: $total"
    echo "$JIRA_URL/issues/?jql=$jql"
}

jr-me() {
    jql="assignee=$JIRA_USER AND resolution = Unresolved order by updated DESC"
    jr-search "$jql"
}
