package main

import (
	"os"
	"testing"
)

func TestHello(t *testing.T) {

	bs, err := os.ReadFile("hello.wasi")
	if err != nil {
		t.Fatal(err)
	}
	if len(bs) < 10 {
		t.Fatal("file is too short")
	}
}
