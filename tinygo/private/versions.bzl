"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
TOOL_VERSIONS = {
    "0.31.2": {
        "darwin-arm64": "sha384-mFeVQGh+vIb7Hz4issK0qfeVDeMIhw1XdFJtA3owfjczAd0UiydHvVQkR44qvZOQ",
        "linux-amd64": "sha384-X+Mjca7lTJhUhsJhTdoeg6J1/M99/EmyOJ1O0VN3L/TmFAQRSyCZTv7EXNysVy3e",
    },
}
