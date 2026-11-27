// Package greet is a local dependency of the embed smoke test.
package greet

import "github.com/google/uuid"

// Greeting formats a string using a third-party dependency.
func Greeting() string {
	return "hello from " + uuid.NameSpaceDNS.String()
}
