package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"reflect"
	"strconv"
	"strings"
)

// {{{ Procon/Init
var proc = &procon{
	sc:      bufio.NewScanner(os.Stdin),
	wtr:     bufio.NewWriter(os.Stdout),
	isDebug: false,
}

type procon struct {
	sc      *bufio.Scanner
	wtr     *bufio.Writer
	isDebug bool
}
type Procon interface {
	// IO
	Int() int
	Int2() (int, int)
	Int3() (int, int, int)
	Int4() (int, int, int, int)
	IntSlice(arg ...int) []int
	IntSlice2(n int) ([]int, []int)
	Int2dSlice(n, m int) [][]int
	NewInt2Slice(l, m int, def int) [][]int
	String() string
	Out(v ...interface{})
	Debug(v ...interface{})
	Flush()

	// Math
	Permutation(x []int) [][]int
	Abs(x int) int
	Pow(p, n int) int
	Equal(a, b any) bool
}

func init() {
	proc.sc.Buffer([]byte{}, math.MaxInt64)
	proc.sc.Split(bufio.ScanWords)
	if len(os.Args) > 1 && os.Args[1] == "i" {
		b, e := os.ReadFile("./tests/sample-1.in")
		if e != nil {
			panic(e)
		}
		proc.sc = bufio.NewScanner(strings.NewReader(strings.Replace(string(b), " ", "\n", -1)))
		proc.isDebug = true
	}
}

// }}}

func main() {
	defer proc.Flush()
	n, m := proc.Int2()
	proc.Out(n * m)
}

// {{{ Procon/Input
func (p procon) Int() int {
	p.sc.Scan()
	i, e := strconv.Atoi(p.sc.Text())
	if e != nil {
		panic(e)
	}
	return i
}

func (p procon) Int2() (int, int) {
	return p.Int(), p.Int()
}

func (p procon) Int3() (int, int, int) {
	return p.Int(), p.Int(), p.Int()
}

func (p procon) Int4() (int, int, int, int) {
	return p.Int(), p.Int(), p.Int(), p.Int()
}

func (p procon) IntSlice(arg ...int) []int {
	n := arg[0]
	t := 0
	if len(arg) == 2 {
		t = arg[1]
	}

	a := make([]int, n)
	for i := 0; i < n; i++ {
		a[i] = p.Int() - t
	}
	return a
}

func (p procon) IntSlice2(n int) ([]int, []int) {
	a := make([]int, n)
	b := make([]int, n)
	for i := 0; i < n; i++ {
		a[i], b[i] = p.Int2()
	}
	return a, b
}

func (p procon) Int2dSlice(n, m int) [][]int {
	a := p.NewInt2Slice(n, m, 0)
	for i := 0; i < n; i++ {
		a[i] = p.IntSlice(m)
	}
	return a
}

func (p procon) NewInt2Slice(l, m int, def int) [][]int {
	sl := make([][]int, l)
	for i := 0; i < l; i++ {
		sl[i] = make([]int, m)
		for j := 0; j < m; j++ {
			sl[i][j] = def
		}
	}
	return sl
}

func (p procon) String() string {
	p.sc.Scan()
	return p.sc.Text()
}

// }}}
// {{{ Procon/Output
func (p procon) Out(v ...interface{}) {
	_, e := fmt.Fprintln(p.wtr, v...)
	if e != nil {
		panic(e)
	}
}

func (p procon) Debug(v ...interface{}) {
	if !p.isDebug {
		return
	}
	p.Out(v...)
}

func (p procon) Flush() {
	p.wtr.Flush()
}

// }}}
// {{{ Procon/Math

func remove(ar []int, i int) []int {
	tmp := make([]int, len(ar))
	copy(tmp, ar)
	return append(tmp[0:i], tmp[i+1:]...)
}

func (p procon) Permutation(x []int) [][]int {
	var result [][]int
	if len(x) == 1 {
		return append(result, x)
	}
	for i, a := range x {
		for _, b := range p.Permutation(remove(x, i)) {
			result = append(result, append([]int{a}, b...))
		}
	}
	return result
}

func (p procon) Abs(x int) int {
	return int(math.Abs(float64(x)))
}

func (_ procon) Pow(p, n int) int {
	return int(math.Pow(float64(p), float64(n)))
}

func (p procon) Equal(a, b any) bool {
	return reflect.DeepEqual(a, b)
}

// }}}
// vim: foldmethod=marker
