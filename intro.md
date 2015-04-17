m4_sinclude(config.m4)
# Introduction

## Readline support for GUILE
( https://www.gnu.org/software/guile/manual/html_node/Loading-Readline-Support.html#Loading-Readline-Support )
```
(use-modules (ice-9 readline))
(activate-readline)
```



## Comment

```scm
; Comment
;; Comment too
```

## Block Comments
(Guile extension) Comment begins with the character sequence #! and ends with the characters !#,

```scm
#! 
This is a comment.
!#
```

## Case Sensitivity
Guile is case sensitive while scheme is **not**. It is possible to turn off case sensitivity in Guile
```scm
(read-enable 'case-insensitive)
```

##Defining and setting variables

```scm
> (define default-translation-string "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG")
>  default-translation-string
$2 = "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG"
```

**Replace** the value
```
> (set! default-translation-string "FFLLSSSSYY**CCWWLLLLPPPPHHQQRRRRIIMMTTTTNNKKSS**VVVVAAAADDEEGGGG")
> default-translation-string
$3 = "FFLLSSSSYY**CCWWLLLLPPPPHHQQRRRRIIMMTTTTNNKKSS**VVVVAAAADDEEGGGG"
```

what's the difference between `define` and `set!` ? http://stackoverflow.com/questions/526082

> Though both define and set! will redefine a value when in the same scope, they do two different things when the scope is different


```scm
(define x 3)

(define (foo)
  (define x 4)
  x)

; Here don't create a new variable with define
; but change previous value
; with set!
(define (bar)
  (set! x 4)
  x)

(foo) ; returns 4
x     ; still 3
(bar) ; returns 4
x     ; is now 4
```


##Let

The general form of a let expression is

```scm
(let ((var expr) ...) body1 body2 ...) 
```

 A let expression is often used to simplify an expression that would contain two identical subexpressions. Doing so also ensures that the value of the common subexpression is computed only once.

```scm
scheme@(guile-user) [4]>  (let ((EcoRI "GAATTC") (BamHI "GGATCC")) (string-append EcoRI BamHI EcoRI EcoRI BamHI ) )
$17 = "GAATTCGGATCCGAATTCGAATTCGGATCC"
```

**Brackets** are often used in place of parentheses to delimit the bindings of a `let` expression. 

```scm
scheme@(guile-user) [4]>  (let ([EcoRI "GAATTC"] [BamHI "GGATCC"])  (string-append EcoRI BamHI EcoRI EcoRI BamHI ) )
$18 = "GAATTCGGATCCGAATTCGAATTCGGATCC"
```

The variables are **bound** to the values by the `let`.


`let` with lamdba expr:
```scm
scheme@(guile-user) [3]>  (let ([polyA (lambda (dna) (string-append dna "AAAAAAAAAAAAAA"))]) (list (polyA "ATGAC") (polyA "CCC") (polyA "ATGC")))
$20 = ("ATGACAAAAAAAAAAAAAA" "CCCAAAAAAAAAAAAAA" "ATGCAAAAAAAAAAAAAA")
```


##  Simple Procedure Invocation
```scm
(define default-translation-string "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG")
(string-length default-translation-string)

$9 = 64
```

```scm
(string-length  (string-append "ATGC" "ATGATAGTA" "AAAAAAAAAAAAA"))

$10 = 26
```

## Creating new procedures with lambda

essential syntax: `lambda <formals> <body>`

```scm
((lambda (name sequence)
	(string-append ">" name "\n" sequence "\n")
	) "EcoRI" "GAATTC")

$14 = ">EcoRI\nGAATTC\n"
```

```scm
(define make-fasta
	(lambda (name sequence)
		(string-append ">" name "\n" sequence "\n")
	 ))
(make-fasta "EcoRI" "GAATTC")

$15 = ">EcoRI\nGAATTC\n"
```

## Creating new procedures without lambda

using is exactly equivalent to the longer lambda form

```scm
(define (make-fasta name sequence) (string-append ">" name "\n" sequence "\n") )
(make-fasta "EcoRI" "GAATTC")
$1 = ">EcoRI\nGAATTC\n"
```

## Vector

```scm
#(1 2 3)
```

> p. 49 of http://www.gnu.org/software/guile/manual/guile.pdf

##Quote expression
http://www.cs.cmu.edu/Groups/AI/html/r4rs/r4rs_6.html

```scm
scheme@(guile-user)> (+ 2 3)
$1 = 5
scheme@(guile-user)> (quote (+ 2 3))
$2 = (+ 2 3)
scheme@(guile-user)> '(+ 2 3)
$3 = (+ 2 3)
```

##If Statement

```scm
scheme@(guile-user)> '(+ 2 3)
$3 = (+ 2 3)
scheme@(guile-user)> (+ 3 7)
$4 = 10
scheme@(guile-user)> (* 3 7)
$5 = 21
scheme@(guile-user)> ((if (< 1 2) + *) 3 7)
$6 = 10
scheme@(guile-user)> ((if (> 1 2) + *) 3 7)
$7 = 21
```

##Car/Cdr 
There are two basic procedures for taking lists apart: car and cdr 

```scm
scheme@(guile-user)> (car '(GAATTC GGATCC CAGCTG))
$1 = GAATTC
scheme@(guile-user)> (cdr '(GAATTC GGATCC CAGCTG))
$2 = (GGATCC CAGCTG)
```

##Building a list
The procedure `cons` constructs lists. 

When the 2nd argument is a **list** `cons` generates an **array**.

```scm
(cons "GAATTC" `())
$3 = ("GAATTC")
scheme@(guile-user) [2]> (cons "GAATTC"  '("GGATCC" "CAGCTG"))
$4 = ("GAATTC" "GGATCC" "CAGCTG")
```

The procedure `list` is similar to cons, except that it takes an arbitrary number of arguments 

```scm
> (cons "CAGCTG"  "GAATTC" "GGATCC" )
;;; <stdin>:12:0: warning: possibly wrong number of arguments to `cons'
> (list  "CAGCTG"  "GAATTC" "GGATCC")
$9 = ("CAGCTG" "GAATTC" "GGATCC")
```


When the 2nd argument is NOT a **list** `cons` generates an **linked-list**.

```scm
> (cons "GAATTC" "GGATCC")
$7 = ("GAATTC" . "GGATCC")




