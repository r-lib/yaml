# Introduction to yaml

``` r
library(yaml)
```

## What is YAML?

YAML is a human-readable data serialization language. With it, you can
create easily readable documents that can be consumed by a variety of
programming languages.

For example, here’s a map of baseball teams per league:

``` yaml
american:
- Boston Red Sox
- Detroit Tigers
- New York Yankees
national:
- New York Mets
- Chicago Cubs
- Atlanta Braves
```

And a data dictionary specification:

``` yaml
- field: ID
  description: primary identifier
  type: integer
  primary key: yes
- field: DOB
  description: date of birth
  type: date
  format: yyyy-mm-dd
- field: State
  description: state of residence
  type: string
```

## Parsing YAML

[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) parses a
YAML document from a string:

``` r
yaml.load("
- 1
- 2
- 3
")
#> [1] 1 2 3
```

[`yaml.load_file()`](https://yaml.r-lib.org/reference/yaml.load.md) and
[`read_yaml()`](https://yaml.r-lib.org/reference/read_yaml.md) read YAML
from a file or connection.

### Scalars

A YAML scalar is the basic building block of YAML documents. The parser
automatically determines the type:

``` r
yaml.load("1.2345")
#> [1] 1.2345
yaml.load("true")
#> [1] TRUE
yaml.load("hello")
#> [1] "hello"
```

### Sequences

A YAML sequence is a list of elements. If all elements are uniform,
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) returns a
vector of that type. Otherwise, it returns a list:

``` r
# Uniform sequence -> vector
yaml.load("
- 1
- 2
- 3
")
#> [1] 1 2 3

# Mixed sequence -> list
yaml.load("
- 1
- hello
- true
")
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] "hello"
#> 
#> [[3]]
#> [1] TRUE
```

### Maps

A YAML map is a list of paired keys and values. By default,
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) returns a
named list:

``` r
yaml.load("
one: 1
two: 2
three: 3
")
#> $one
#> [1] 1
#> 
#> $two
#> [1] 2
#> 
#> $three
#> [1] 3
```

Since YAML map keys can be almost anything (not just strings), you can
preserve the data type of keys with `as.named.list = FALSE`. This
creates a `keys` attribute instead of coercing keys to strings:

``` r
yaml.load("
1: one
2: two
", as.named.list = FALSE)
#> [[1]]
#> [1] "one"
#> 
#> [[2]]
#> [1] "two"
#> 
#> attr(,"keys")
#> attr(,"keys")[[1]]
#> [1] 1
#> 
#> attr(,"keys")[[2]]
#> [1] 2
```

### Custom handlers

You can customize parsing with handler functions. Handlers are passed to
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) as a
named list, where each name is the YAML type to handle:

``` r
# Add 100 to all integers
yaml.load("123", handlers = list(int = function(x) as.integer(x) + 100))
#> [1] 223
```

#### Sequence handlers

Sequence handlers receive a list and can transform it:

``` r
yaml.load("
- 1
- 2
- 3
", handlers = list(seq = function(x) sum(as.numeric(x))))
#> [1] 6
```

#### Map handlers

Map handlers receive a named list (or a list with a `keys` attribute):

``` r
yaml.load("
a:
- 1
- 2
b:
- 3
- 4
", handlers = list(map = function(x) as.data.frame(x)))
#>   a b
#> 1 1 3
#> 2 2 4
```

## Emitting YAML

[`as.yaml()`](https://yaml.r-lib.org/reference/as.yaml.md) converts R
objects to YAML strings:

``` r
cat(as.yaml(1:5))
#> - 1
#> - 2
#> - 3
#> - 4
#> - 5
```

[`write_yaml()`](https://yaml.r-lib.org/reference/write_yaml.md) writes
the result directly to a file or connection.

### Formatting options

#### indent

Control indentation depth (default is 2):

``` r
cat(as.yaml(list(foo = list(bar = "baz")), indent = 4))
#> foo:
#>     bar: baz
```

#### indent.mapping.sequence

By default, sequences within a mapping are not indented:

``` r
cat(as.yaml(list(foo = 1:3)))
#> foo:
#> - 1
#> - 2
#> - 3
```

Set `indent.mapping.sequence = TRUE` to indent them:

``` r
cat(as.yaml(list(foo = 1:3), indent.mapping.sequence = TRUE))
#> foo:
#>   - 1
#>   - 2
#>   - 3
```

#### column.major

Controls how data frames are converted. When `TRUE` (default), data
frames are emitted column-wise:

``` r
x <- data.frame(a = 1:2, b = 3:4)
cat(as.yaml(x, column.major = TRUE))
#> a:
#> - 1
#> - 2
#> b:
#> - 3
#> - 4
```

When `FALSE`, data frames are emitted row-wise:

``` r
cat(as.yaml(x, column.major = FALSE))
#> - a: 1
#>   b: 3
#> - a: 2
#>   b: 4
```

### Custom handlers

Specify custom handler functions for R object classes:

``` r
cat(as.yaml(
  Sys.Date(),
  handlers = list(Date = function(x) format(x, "%Y/%m/%d"))
))
#> 2025/12/05
```

### YAML 1.2 logical handling

For YAML 1.2-like logical output, use `verbatim_logical`:

``` r
cat(as.yaml(c(TRUE, FALSE), handlers = list(logical = verbatim_logical)))
#> - true
#> - false
```

### Verbatim text

Character vectors with class `"verbatim"` are not quoted except when
required by the YAML specification:

``` r
result <- c("true", "false")
class(result) <- "verbatim"
cat(as.yaml(result))
#> - true
#> - false
```

### Quoted strings

Force quoting with the `"quoted"` attribute:

``` r
port <- "80:80"
attr(port, "quoted") <- TRUE
cat(as.yaml(list(ports = list(port))))
#> ports:
#> - "80:80"
```

### Custom tags

Set YAML tags with the `"tag"` attribute:

``` r
x <- 1:3
attr(x, "tag") <- "!custom"
cat(as.yaml(x))
#> !custom
#> - 1
#> - 2
#> - 3
```
