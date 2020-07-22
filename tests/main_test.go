package tests

import (
	"fmt"
	"github.com/ComuneFI/queryparser"
	"os"
	"testing"
)

func TestMain(m *testing.M) {
	src := "   dataopen =  2020-07-10  "
	q, exception := queryparser.Parse(src)
	if exception != nil {
		fmt.Println(exception.Error() + ":\r\n" + src + "\r\n" + exception.Cursor())

	} else {
		fmt.Println(*q)
	}
	os.Exit(m.Run())

}
