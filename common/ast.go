package common

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
)

type Token struct {
	Position int
	Token    int
	Literal  string
}
type TokenValue struct {
	Token   int
	Content interface{}
}
type Condition struct {
	Variable   Token
	Comparator Token
	Value      TokenValue
}

type Date struct {
	day   uint8
	month uint8
	year  uint16
}

type Time struct {
	hour        uint8
	minutes     uint8
	seconds     uint8
	zoneHour    int8
	zoneMinutes uint8
}

type Duration struct {
	hour    int8
	minutes uint8
	seconds uint8
}

type DateTime struct {
	date Date
	time Time
}

func daysInMonth(m uint8, y uint16) uint8 { // m is 0 indexed: 0-11
	switch m {
	case 2:
		if (y%4 == 0 && y%100 == 0) || y%400 == 0 {
			return 29
		} else {
			return 28
		}

	case 9:
		fallthrough
	case 4:
		fallthrough
	case 6:
		fallthrough
	case 11:
		return 30

	default:
		return 31
	}
}

func (l *Date) Parse(s string) error {
	t := strings.Split(s, "-")
	y, _ := strconv.ParseUint(t[0], 10, 16)
	m, _ := strconv.ParseUint(t[1], 10, 8)
	d, _ := strconv.ParseUint(t[2], 10, 8)
	return l.Set(uint16(y), uint8(m), uint8(d))

}

func (l *Date) Set(year uint16, month, day uint8) error {
	if month > 12 {
		return errors.New("invalid month")
	}
	if day > daysInMonth(month, year) {
		return errors.New("invalid day")
	}
	l.year = year
	l.month = month
	l.day = day
	return nil
}
func (l *Date) Day() uint8 {
	return l.day
}
func (l *Date) Year() uint16 {
	return l.year
}
func (l *Date) Month() uint8 {
	return l.month
}
func (l *Date) String() string {
	str := fmt.Sprintf("%d-%d-%d", l.year, l.month, l.day)
	return str
}
func (l *DateTime) Date() Date {
	return l.date
}
func (l *DateTime) Time() Time {
	return l.time
}
func (l DateTime) String() string {

	return l.date.String() + " " + l.time.String()
}

func (l *DateTime) Set(date Date, time Time) {
	l.date = date
	l.time = time
}
func ParseDateTime(str string) (*DateTime, error) {
	t := DateTime{}
	e := t.Parse(str)
	if e != nil {
		return nil, e
	}
	return &t, nil
}
func (l *DateTime) Parse(str string) error {
	i := strings.IndexAny(str, "T")
	if i < 0 {
		return errors.New("invalid time field")
	}
	d, e1 := ParseDate(str[0:i])
	if e1 != nil {
		return e1
	}
	t, e2 := ParseTime(str[i+1:])
	if e2 != nil {
		return e2
	}
	l.date = *d
	l.time = *t
	return nil

}

func (l *Duration) Set(hour int8, min, sec uint8) error {
	if hour >= 24 {
		return errors.New("invalid hour")
	}
	if min >= 60 {
		return errors.New("invalid minutes")
	}
	if sec >= 60 {
		return errors.New("invalid seconds")
	}

	l.hour = hour
	l.minutes = min
	l.seconds = sec

	return nil
}
func (l *Time) Set(hour, min, sec uint8, zhour int8, zmin uint8) error {
	if hour >= 24 {
		return errors.New("invalid hour")
	}
	if min >= 60 {
		return errors.New("invalid minutes")
	}
	if sec >= 60 {
		return errors.New("invalid seconds")
	}
	if zmin >= 60 {
		return errors.New("invalid zone minutes")
	}
	l.hour = hour
	l.minutes = min
	l.seconds = sec
	l.zoneHour = zhour
	l.zoneMinutes = zmin
	return nil
}
func ParseTime(str string) (*Time, error) {
	t := Time{}
	e := t.Parse(str)
	if e != nil {
		return nil, e
	}
	return &t, nil
}
func ParseDuration(str string) (*Duration, error) {
	t := Duration{}
	e := t.Parse(str)
	if e != nil {
		return nil, e
	}
	return &t, nil
}
func ParseDate(str string) (*Date, error) {
	t := Date{}
	e := t.Parse(str)
	if e != nil {
		return nil, e
	}
	return &t, nil
}
func (l *Time) Parse(str string) error {
	i := strings.IndexAny(str, "+")
	if i == -1 {
		i = strings.IndexAny(str, "-")
	}
	if i < 0 {
		return errors.New("invalid timezone field")
	}
	t := strings.Split(str[0:i], ":")
	h, _ := strconv.ParseUint(t[0], 10, 8)
	m, _ := strconv.ParseUint(t[1], 10, 8)
	s, _ := strconv.ParseUint(t[2], 10, 8)
	z := strings.Split(str[i:], ":")
	zh, _ := strconv.ParseInt(z[0], 10, 8)
	zm, _ := strconv.ParseUint(z[1], 10, 8)
	return l.Set(uint8(h), uint8(m), uint8(s), int8(zh), uint8(zm))

}
func (l *Duration) Parse(str string) error {
	t := strings.Split(str, ":")
	h, _ := strconv.ParseInt(t[0], 10, 8)
	m, _ := strconv.ParseUint(t[1], 10, 8)
	s, _ := strconv.ParseUint(t[2], 10, 8)

	return l.Set(int8(h), uint8(m), uint8(s))

}
func (l *Time) Hour() uint8 {
	return l.hour
}
func (l *Time) Minutes() uint8 {
	return l.minutes
}
func (l *Time) Seconds() uint8 {
	return l.seconds
}
func (l *Time) ZoneMinutes() uint8 {
	return l.zoneMinutes
}
func (l *Time) ZoneHour() int8 {
	return l.zoneHour
}
func (l *Time) ZoneOffset() int {
	return (int(l.zoneHour)*60 + int(l.zoneMinutes)) * 60
}
func (l *Time) Offset() int {
	return ((int(l.zoneHour)+int(l.hour))*60+int(l.zoneMinutes)+int(l.minutes))*60 + int(l.seconds)
}
func (l *Duration) Hour() int8 {
	return l.hour
}
func (l *Duration) Minutes() uint8 {
	return l.minutes
}
func (l *Duration) Seconds() uint8 {
	return l.seconds
}
func (l *Duration) Offset() int {
	return ((int(l.hour))*60+int(l.minutes))*60 + int(l.seconds)
}
func (l *Time) String() string {
	str := fmt.Sprintf("%02d:%02d:%02d", l.hour, l.minutes, l.seconds)
	if l.zoneHour >= 0 {
		str += "+"
	} else {
		str += "-"
	}
	return str + fmt.Sprintf("%02d:%02d", l.zoneHour, l.zoneMinutes)
}
func (l *Duration) String() string {
	str := fmt.Sprintf("%02d:%02d:%02d", l.hour, l.minutes, l.seconds)

	return str
}
func (l Condition) String() string {
	str := fmt.Sprintf("%v", l.Value.Content)
	return l.Variable.Literal + " " + l.Comparator.Literal + " " + str
}

type Expression interface {
	String() string
}

type SubExpression struct {
	Expr Expression
}

func (l SubExpression) String() string {
	return "(" + (l.Expr).String() + ")"
}

type NotExpression struct {
	Expr Expression
}

func (l NotExpression) String() string {
	return "NOT " + (l.Expr).String()
}

type BiExpression struct {
	BooleanOperator Token
	Left            Expression
	Right           Expression
}

func (l BiExpression) String() string {
	var s string
	if l.Right != nil {
		s = (l.Left).String() + " " + (l.BooleanOperator).Literal + " " + (l.Right).String()
	} else {
		s = (l.BooleanOperator).Literal + " " + (l.Left).String()
	}
	return s
}
