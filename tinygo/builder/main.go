package main

import (
	"fmt"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
func run() error {

	path := os.Getenv("BUILDER_GOBIN_PATH")
	abs, err := filepath.Abs(path)
	if err != nil {
		return err
	}

	cmd := exec.Command(os.Args[1], os.Args[2:]...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	cmd.Env = os.Environ()
	cmd.Env = append(cmd.Env, fmt.Sprintf("PATH=%s", abs))

	// goroot
	goroot := os.Getenv("BUILDER_GOROOT")
	if goroot == "" {
		return fmt.Errorf("BUILDER_GOROOT is not set")
	}
	goroot, err = filepath.Abs(goroot)
	if err != nil {
		return err
	}
	cmd.Env = append(cmd.Env, fmt.Sprintf("GOROOT=%s", goroot))

	tinyGoRoot := os.Getenv("BUILDER_TINYGOROOT")
	if tinyGoRoot == "" {
		return fmt.Errorf("BUILDER_TINYGOROOT is not set")
	}
	tinyGoRoot, err = filepath.Abs(tinyGoRoot)
	if err != nil {
		return err
	}

	cmd.Env = append(cmd.Env, fmt.Sprintf("TINYGOROOT=%s", tinyGoRoot))

	if gomodDir := os.Getenv("BUILDER_GOMOD_DIR"); gomodDir != "" {
		gomodDir, err = filepath.Abs(gomodDir)
		if err != nil {
			return err
		}
		if err := copyPackageSources(gomodDir); err != nil {
			return err
		}
		cmd.Dir = gomodDir
	}

	if err := cmd.Run(); err != nil {
		return err
	}

	return nil
}

func copyPackageSources(gomodDir string) error {
	specs := os.Getenv("BUILDER_COPY_SPECS")
	if specs == "" {
		return nil
	}
	for _, spec := range strings.Split(specs, ",") {
		parts := strings.SplitN(spec, "|", 2)
		if len(parts) != 2 {
			return fmt.Errorf("invalid BUILDER_COPY_SPECS entry %q", spec)
		}
		dest := filepath.Join(gomodDir, parts[0])
		if err := os.MkdirAll(filepath.Dir(dest), 0o755); err != nil {
			return err
		}
		src, err := filepath.Abs(parts[1])
		if err != nil {
			return err
		}
		data, err := os.ReadFile(src)
		if err != nil {
			return err
		}
		if err := os.WriteFile(dest, data, 0o644); err != nil {
			return err
		}
	}
	return nil
}

func tree() {
	_ = filepath.WalkDir(".", func(path string, d fs.DirEntry, err error) error {
		fmt.Println(path)
		return nil
	})
}
