"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
TOOL_VERSIONS = {
    "0.31.2": {
        "darwin-arm64": "sha384-mFeVQGh+vIb7Hz4issK0qfeVDeMIhw1XdFJtA3owfjczAd0UiydHvVQkR44qvZOQ",
        "linux-amd64": "sha384-MI3PjWKAVVP9+ssV79VtPhSUJmffZTt8gTw8vFvQTu5yAzeojI1T3J26yQHFQyws",
    },
}
