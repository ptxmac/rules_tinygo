// Command langversion checks that language features newer than Go 1.21 work
// when TinyGo builds from a GOPATH tree, where no go.mod sets the version.
package main

func main() {
	// Go 1.22: each iteration has its own copy of the loop variable.
	var fs []func() int
	for i := 0; i < 3; i++ {
		fs = append(fs, func() int { return i })
	}
	sum := 0
	for _, f := range fs {
		sum += f()
	}

	// Go 1.22: range over an integer.
	n := 0
	for range 4 {
		n++
	}

	// Go 1.23: range over a function.
	seq := func(yield func(int) bool) {
		for i := range 3 {
			if !yield(i) {
				return
			}
		}
	}
	m := 0
	for v := range seq {
		m += v
	}

	println(sum, n, m)
}
