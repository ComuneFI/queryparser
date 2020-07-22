// Author 2020 Cristian Lorenzetto. 


%{

package parser

import (

	


	"strconv"
	"regexp"
	"github.com/ComuneFI/queryparser/common"
)



%}
// fields inside this union end up as the fields in a structure known
// as ${PREFIX}SymType, of which a reference is passed to the lexer.
%union{
	expr  common.Expression
    cond common.Condition
	token common.Token

}

%token <token> IDENT
%token <token> STRING
%token <token> INT
%token <token> FLOAT
%token <token> BOOL
%token <token> EQ
%token <token> NEQ
%token <token> LT
%token <token> GT
%token <token> LTE
%token <token> GTE
%token <token> LPAREN
%token <token> RPAREN
%token <token> AND 
%token <token> NOT
%token <token> OR
%token <token> LIKE
%token <token> NLIKE
%token <token> DATE
%token <token> DATETIME
%token <token> TIME
%token <token> DURATION

%type <expr> expr
%type <cond> condition

%left AND
%left OR
%left NOT


%%

expr : condition {
	$$ =$1
	Querylex.(*QueryLexerImpl).AST = $$

} 
| LPAREN expr RPAREN 
{   
	$$ = common.SubExpression{Expr:$2}
	Querylex.(*QueryLexerImpl).AST = $$

}

| expr AND expr {
	$$ = common.BiExpression{BooleanOperator:$2,Left:$1,Right:$3}
    Querylex.(*QueryLexerImpl).AST = $$

}
| expr OR expr {
	$$ = common.BiExpression{BooleanOperator:$2,Left:$1,Right:$3}
	Querylex.(*QueryLexerImpl) .AST= $$
} | NOT expr {
  	$$ = common.NotExpression{Expr:$2}
  	Querylex.(*QueryLexerImpl) .AST= $$
  }
;


condition :  IDENT EQ STRING 
{
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:$3.Literal}}
} 
| IDENT NEQ STRING 
{
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:$3.Literal}}
}
| IDENT LT STRING
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT GT STRING
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT LTE STRING
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT GTE STRING
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT LIKE STRING 
{
$$ =common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:$3.Literal}}
} 
| IDENT NLIKE STRING 
{
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:$3.Literal}}
} 
| IDENT EQ BOOL 
{
b, e := strconv.ParseBool($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:b}}
} 
| IDENT NEQ BOOL
{
b, e := strconv.ParseBool($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:b}}
}
| IDENT LT BOOL
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT GT BOOL
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT LTE BOOL
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT GTE BOOL
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT LIKE BOOL
 {
 	ql ,_:=Querylex.(*QueryLexerImpl)
 				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
 				break
 }
 | IDENT NLIKE BOOL
 {
 	ql ,_:=Querylex.(*QueryLexerImpl)
 				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
 				break
 }
| IDENT EQ INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT LIKE INT
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT NLIKE INT
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT NEQ INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT LIKE FLOAT
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT NLIKE FLOAT
{
	ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
				break
}
| IDENT EQ FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT NEQ FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT GT INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT LT INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT GT FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT LT FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT GTE INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT LTE INT
{
i, e := strconv.ParseInt($3.Literal, 10, 64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:i}}

}
| IDENT GTE FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT LTE FLOAT
{
f, e := strconv.ParseFloat($3.Literal,  64)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:f}}

}
| IDENT EQ DATE
{
t, e := common.ParseDate($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT EQ DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT EQ TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT EQ DURATION
{
t, e := common.ParseDuration($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT NEQ DATE
{
t, e := common.ParseDate($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT  NEQ  DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT NEQ TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT NEQ DURATION
{
t, e := common.ParseDuration($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LT DATE
{
t, e := common.ParseDate($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT  LT  DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LT TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LT DURATION
{
t, e := common.ParseDuration($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GT DATE
{
t, _ := common.ParseDate($3.Literal)
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT  GT  DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GT TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GT DURATION
{
t, e := common.ParseDuration($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LTE DATE
{
t, e := common.ParseDate($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT  LTE  DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LTE TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT LTE DURATION
{
t, e := common.ParseDuration($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GTE DATE
{
t, e := common.ParseDate($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT  GTE  DATETIME
{
t, e := common.ParseDateTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
$$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GTE TIME
{
t, e := common.ParseTime($3.Literal)
if e != nil {
				ql ,_:=Querylex.(*QueryLexerImpl)
				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


				break
}
 $$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

}
| IDENT GTE DURATION
 {
 t, e := common.ParseDuration($3.Literal)
 if e != nil {
 				ql ,_:=Querylex.(*QueryLexerImpl)
 				ql.PositionedError(QueryDollar[3].token.Position,e.Error())


 				break
 }
 $$ = common.Condition{Variable:$1,Comparator:$2,Value:common.TokenValue{Token:$3.Token,Content:*t}}

 }| IDENT LIKE DATE
  {
  	ql ,_:=Querylex.(*QueryLexerImpl)
  				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
  				break
  }
  | IDENT LIKE DATETIME
    {
    	ql ,_:=Querylex.(*QueryLexerImpl)
    				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
    				break
    }
    | IDENT LIKE TIME
      {
      	ql ,_:=Querylex.(*QueryLexerImpl)
      				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
      				break
      }
      | IDENT NLIKE DATE
        {
        	ql ,_:=Querylex.(*QueryLexerImpl)
        				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
        				break
        }
        | IDENT NLIKE DATETIME
          {
          	ql ,_:=Querylex.(*QueryLexerImpl)
          				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
          				break
          }
          | IDENT NLIKE TIME
            {
            	ql ,_:=Querylex.(*QueryLexerImpl)
            				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
            				break
            }
                 | IDENT LIKE DURATION
                   {
                   	ql ,_:=Querylex.(*QueryLexerImpl)
                   				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
                   				break
                   }

                        | IDENT NLIKE DURATION
                          {
                          	ql ,_:=Querylex.(*QueryLexerImpl)
                          				ql.PositionedError(QueryDollar[2].token.Position,"invalid operator")
                          				break
                          }
;



%%      /*  start  of  programs  */

type QueryLexerImpl struct {
	src             string
	pos             int
	re              *regexp.Regexp
	Exception       *common.Exception
	AST             common.Expression

}





func (l *QueryLexerImpl) PositionedError(pos int, msg string) {
	l.Exception = &common.Exception{}

	s := l.src[pos:]
	l.Exception.Init(pos, msg+" at "+s)
}

func (l *QueryLexerImpl) Init(src string) {
	l.src = src
	l.pos = 0
	l.re = regexp.MustCompile(`^((?P<op>((OR)|(NOT)|(AND)))|(?P<comp>((\!\=)|(\!\~)|(\<\=)|(\>\=)|(\=)|(\~)|(\>)|(\<)))|(?P<bool>((true)|(false)))|(?P<string>\"(?:[^"\\]|\\.)*\")|(?P<ident>[A-Za-z]\w*)|(?P<time>((\d{4}\-\d{2}\-\d{2})(T(\d{1,2}\:\d{2}((\:\d{2}(\:\d{2})?)?)(([-+]\d{2}\:\d{2})|Z)?))?)|([-+]?\d{1,2}\:\d{2}((\:\d{2}(\:\d{2})?)?)(([-+]\d{2}\:\d{2})|Z)?))|(?P<number>([-+]?\d+)(\.\d+)?))`)
}

func (l *QueryLexerImpl) Lex(lval *QuerySymType) int {
	if l.Exception!=nil{
		return -1
	}
	var t int = -1
	len := len(l.src)
	// remove all spaces on the left
	for l.pos < len && (l.src[l.pos] == ' ' || l.src[l.pos] == '\t') {
		l.pos++

	}
	if l.pos == len {
		return -1
	}

	if l.src[l.pos] == '(' {
		t = LPAREN
		lval.token = common.Token{Position: l.pos, Token: t, Literal: "("}
		l.pos++
		return t
	} else if l.src[l.pos] == ')' {
		t = RPAREN
		lval.token = common.Token{Position: l.pos, Token: t, Literal: ")"}
		l.pos++
		return t
	}
	//find the leftmost token (and its subtokens)
	result := l.re.FindSubmatchIndex([]byte(l.src[l.pos:]))
	if result == nil {
		return -1
	}
	for pairIndex := 2; t == -1 && pairIndex < 84; pairIndex += 2 {

		rstart := result[pairIndex]
		if rstart != -1 {
			start := l.pos + result[pairIndex]
			switch pairIndex {
			// comparator
			case 18:
				t = NEQ
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "!="}
				break
			case 20:
				t = NLIKE
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "!~"}
				break
			case 22:
				t = LTE
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "<="}
				break
			case 24:
				t = GTE
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: ">="}
				break
			case 26:
				t = EQ
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "="}
				break
			case 28:
				t = LIKE
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "~"}
				break
			case 30:
				t = GT
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: ">"}
				break
			case 32:
				t = LT
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "<"}
				break
			case 78:
				if result[82] != -1 {
					t = FLOAT
				} else {
					t = INT
				}
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start : l.pos+result[pairIndex+1]]}
				break
				// string
			case 42: //SHIFT
				t = STRING
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start+1 : l.pos+result[pairIndex+1]-1]}
				break
			case 8:
				t = OR
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "OR"}
				break
			case 10:
				t = NOT
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "NOT"}
				break
			case 12:
				t = AND
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: "AND"}
				break
			case 36:
				t = BOOL
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start : l.pos+result[pairIndex+1]]}
				break
			case 44: // gia' sfhittato
				t = IDENT
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start : l.pos+result[pairIndex+1]]}
				break
			case 66:
				ch := l.src[l.pos+result[66]]
				if ch == '+' || ch == '-' {
					t = DURATION
				} else {
					t = TIME
				}

				s := ""
				var index = pairIndex + 1
				if result[70] == -1 {
					s += ":00"
					if result[74] != -1 {
						s += l.src[l.pos+result[74] : l.pos+result[75]]
						index = 74
					}
				}
				if t == TIME {
					if result[74] == -1 {
						s += "+00:00"
					} else if l.src[result[74]] == 'Z' {
						index--
						s += "+00:00"
					}
				} else {
					if result[74] != -1 {
						return -1
					}
				}
				lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start:l.pos+result[index]] + s}
				break
			case 48:
				s := ""
				if result[52] != -1 {
					t = DATETIME
					var index = pairIndex + 1
					if result[58] == -1 {
						s = ":00"
						if result[62] != -1 {
							s += l.src[l.pos+result[62] : l.pos+result[63]]
							index = 62
						}
					}
					if result[62] == -1 {
						s += "+00:00"
					} else if l.src[result[62]] == 'Z' {
						index--
						s += "+00:00"
					}

					lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start:l.pos+result[index]] + s}

				} else {
					t = DATE

					lval.token = common.Token{Position: l.pos + start, Token: t, Literal: l.src[start:l.pos+result[pairIndex+1]] }
				}

				break

			}
			if t != -1 {
				l.pos += result[pairIndex+1]
				if l.pos != len && l.src[l.pos] != ' ' {
					t = -1
					l.pos -= result[pairIndex+1]
                    l.PositionedError(l.pos,"invalid token")
					return t
				}
			}

		}

	}

	return t
}
func (l *QueryLexerImpl) Error(e string) {
	l.Exception = &common.Exception{}


		s := l.src[l.pos:]
		l.Exception.Init(l.pos, e+" at "+s)

}
