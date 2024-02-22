package main

import (
	"fmt"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
)

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
func run() error {
	log.Println("ARGS: ", len(os.Args))

	for i, arg := range os.Args {
		log.Printf("ARG[%d]: %s", i, arg)
	}

	env := os.Environ()
	sort.Strings(env)

	log.Println("ENV: ", len(env))

	for i, e := range env {
		log.Printf("ENV[%d]: %s", i, e)
	}

	path := os.Getenv("BUILDER_GOBIN_PATH")
	abs, err := filepath.Abs(path)
	if err != nil {
		return err
	}

	//tree()

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

	if err := cmd.Run(); err != nil {
		return err
	}

	return nil
}

func tree() {
	_ = filepath.WalkDir(".", func(path string, d fs.DirEntry, err error) error {
		fmt.Println(path)
		return nil
	})
}
