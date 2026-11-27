package langversion_test

import (
	"os/exec"
	"strings"
	"testing"
)

// TestLanguageVersion runs the host binary built by TinyGo. The expected
// output checks Go 1.22 per-iteration loop variables, Go 1.22 range over int,
// and Go 1.23 range over func.
func TestLanguageVersion(t *testing.T) {
	out, err := exec.Command("./langversion").CombinedOutput()
	if err != nil {
		t.Fatalf("running langversion: %v\n%s", err, out)
	}
	if got, want := strings.TrimSpace(string(out)), "3 4 3"; got != want {
		t.Errorf("got %q, want %q", got, want)
	}
}
