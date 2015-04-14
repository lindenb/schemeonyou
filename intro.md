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

p. 49 of http://www.gnu.org/software/guile/manual/guile.pdf

