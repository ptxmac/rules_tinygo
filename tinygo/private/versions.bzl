"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
TOOL_VERSIONS = {
    "0.31.2": {
        "darwin-arm64": "sha384-mFeVQGh+vIb7Hz4issK0qfeVDeMIhw1XdFJtA3owfjczAd0UiydHvVQkR44qvZOQ",
        "linux-amd64": "sha384-X+Mjca7lTJhUhsJhTdoeg6J1/M99/EmyOJ1O0VN3L/TmFAQRSyCZTv7EXNysVy3e",
        "linux-arm64": "sha384-4KYc4hHxeuL/Rt48n/IDc8r+xqWfWwZVFvuB4E41LToWt+P1N6Na17dAzLD0YOH/",
    },
    "0.35.0": {
        "darwin-arm64": "sha384-Xyt1WbhDd92Zadb7Ku/YFxI0T8iKS0nqnp+HpYe914NNVSERL+2ZX1CjKBSA60ch",
    },
}
