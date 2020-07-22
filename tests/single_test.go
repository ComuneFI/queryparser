package tests

import (
	"fmt"
	"testing"

	"github.com/ComuneFI/queryparser"
)

const (
	InfoColor    = "\033[1;34m%s\033[0m"
	NoticeColor  = "\033[1;36m%s\033[0m"
	WarningColor = "\033[1;33m%s\033[0m"
	ErrorColor   = "\033[1;31m%s\033[0m"
	DebugColor   = "\033[0;36m%s\033[0m"
)

func testparser(query string) {
	fmt.Printf(WarningColor, query)
	fmt.Println("")
	item, error := queryparser.Parse(query)
	fmt.Println("Risultato:")
	if error != nil {
		fmt.Printf(ErrorColor, error)
		fmt.Println("")
	} else {
		fmt.Println(*item)
	}

}

func fortestAB(op []string) {
	for i := 0; i < len(op); i++ {

		fmt.Println("*** Inizio Test " + op[i] + " ***")
		query := " a " + op[i] + " b "
		testparser(query)
		fmt.Println("")

	}
}

func fortestEq(op []string) {
	cond := []string{"=", "!=", "!~", "<=", ">=", "=", "~", ">", "<"}
	for i := 0; i < len(op); i++ {
		for j := 0; j < len(cond); j++ {
			fmt.Println("*** Inizio Test " + op[i] + " ***")
			query := " a " + cond[j] + " " + op[i]
			testparser(query)
			fmt.Println("")

		}
	}
}

func TestConditionLogic(t *testing.T) {
	op := []string{"AND", "NOT", "OR"}
	fortestAB(op)
}

func TestCondition(t *testing.T) {
	op := []string{"=", "!=", "!~", "<=", ">=", "=", "~", ">", "<"}
	fortestAB(op)
}

func TestBolean(t *testing.T) {
	op := []string{"true", "false"}
	fortestEq(op)
}

func TestString(t *testing.T) {
	op := []string{"\"stringa 1\"", "\"stringa 2\""}
	fortestEq(op)
}

func TestNumber(t *testing.T) {
	op := []string{"10", "11"}
	fortestEq(op)
}

func TestDateTime(t *testing.T) {
	op := []string{"2020-07-15T15:04:05Z", "2020-07-15T15:04", "2020-07-15T15:04:05+00:00"}
	fortestEq(op)

}
func TestDate(t *testing.T) {
	op := []string{"2020-07-15"}
	fortestEq(op)
}
func TestTime(t *testing.T) {
	op := []string{"15:04", "15:04:00"}
	fortestEq(op)

}
