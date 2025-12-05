# Convert an R object into a YAML string

If you set the `omap` option to TRUE, as.yaml will create ordered maps
(or omaps) instead of normal maps.

## Usage

``` r
as.yaml(
  x,
  line.sep = c("\n", "\r\n", "\r"),
  indent = 2,
  omap = FALSE,
  column.major = TRUE,
  unicode = TRUE,
  precision = getOption("digits"),
  indent.mapping.sequence = FALSE,
  handlers = NULL
)
```

## Arguments

- x:

  The object to be converted.

- line.sep:

  The line separator character(s) to use.

- indent:

  The number of spaces to use for indenting.

- omap:

  Determines whether or not to convert a list to a YAML omap; see
  Details.

- column.major:

  Determines how to convert a data.frame; see Details.

- unicode:

  Determines whether or not to allow unescaped unicode characters in
  output.

- precision:

  Number of significant digits to use when formatting numeric values.

- indent.mapping.sequence:

  Determines whether or not to indent sequences in mapping context.

- handlers:

  Named list of custom handler functions for R objects; see Details.

## Value

Returns a YAML string which can be loaded using
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) or copied
into a file for external use.

## Details

The `column.major` option determines how a data frame is converted. If
TRUE, the data frame is converted into a map of sequences where the name
of each column is a key. If FALSE, the data frame is converted into a
sequence of maps, where each element in the sequence is a row. You'll
probably almost always want to leave this as TRUE (which is the
default), because using
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) on the
resulting string returns an object which is much more easily converted
into a data frame via
[`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html).

You can specify custom handler functions via the `handlers` argument.
This argument must be a named list of functions, where the names are R
object class names (i.e., 'numeric', 'data.frame', 'list', etc). The
function(s) you provide will be passed one argument (the R object) and
can return any R object. The returned object will be emitted normally.

Character vectors that have a class of ‘verbatim’ will not be quoted in
the output YAML document except when the YAML specification requires it.
This means that you cannot do anything that would result in an invalid
YAML document, but you can emit strings that would otherwise be quoted.
This is useful for changing how logical vectors are emitted (see below
for example).

Character vectors that have an attribute of ‘quoted’ will be wrapped in
double quotes (see below for example).

You can specify YAML tags for R objects by setting the ‘tag’ attribute
to a character vector of length 1. If you set a tag for a vector, the
tag will be applied to the YAML sequence as a whole, unless the vector
has only 1 element. If you wish to tag individual elements, you must use
a list of 1-length vectors, each with a tag attribute. Likewise, if you
set a tag for an object that would be emitted as a YAML mapping (like a
data frame or a named list), it will be applied to the mapping as a
whole. Tags can be used in conjunction with YAML deserialization
functions like
[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md) via
custom handlers, however, if you set an internal tag on an incompatible
data type (like “!seq 1.0”), errors will occur when you try to
deserialize the document.

## References

YAML: http://yaml.org

YAML omap type: http://yaml.org/type/omap.html

## See also

[`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md)

## Author

Jeremy Stephens <jeremy.f.stephens@vumc.org>

## Examples

``` r
  as.yaml(1:10)
#> [1] "- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n- 9\n- 10\n"
  as.yaml(list(foo=1:10, bar=c("test1", "test2")))
#> [1] "foo:\n- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n- 9\n- 10\nbar:\n- test1\n- test2\n"
  as.yaml(list(foo=1:10, bar=c("test1", "test2")), indent=3)
#> [1] "foo:\n- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n- 9\n- 10\nbar:\n- test1\n- test2\n"
  as.yaml(list(foo=1:10, bar=c("test1", "test2")), indent.mapping.sequence=TRUE)
#> [1] "foo:\n  - 1\n  - 2\n  - 3\n  - 4\n  - 5\n  - 6\n  - 7\n  - 8\n  - 9\n  - 10\nbar:\n  - test1\n  - test2\n"
  as.yaml(data.frame(a=1:10, b=letters[1:10], c=11:20))
#> [1] "a:\n- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n- 9\n- 10\nb:\n- a\n- b\n- c\n- d\n- e\n- f\n- g\n- h\n- i\n- j\nc:\n- 11\n- 12\n- 13\n- 14\n- 15\n- 16\n- 17\n- 18\n- 19\n- 20\n"
  as.yaml(list(a=1:2, b=3:4), omap=TRUE)
#> [1] "!!omap\n- a:\n  - 1\n  - 2\n- b:\n  - 3\n  - 4\n"
  as.yaml("multi\nline\nstring")
#> [1] "|-\n  multi\n  line\n  string\n"
  as.yaml(function(x) x + 1)
#> [1] "!expr |\n  function (x)\n  x + 1\n"
  as.yaml(list(foo=list(list(x = 1, y = 2), list(x = 3, y = 4))))
#> [1] "foo:\n- x: 1.0\n  'y': 2.0\n- x: 3.0\n  'y': 4.0\n"

  # custom handler
  as.yaml(Sys.time(), handlers = list(
    POSIXct = function(x) format(x, "%Y-%m-%d")
  ))
#> [1] "'2025-12-05'\n"

  # custom handler with verbatim output to change how logical vectors are
  # emitted
  as.yaml(c(TRUE, FALSE), handlers = list(
    logical = verbatim_logical))
#> [1] "- true\n- false\n"

  # force quotes around a string
  port_def <- "80:80"
  attr(port_def, "quoted") <- TRUE
  x <- list(ports = list(port_def))
  as.yaml(x)
#> [1] "ports:\n- \"80:80\"\n"

  # custom tag for scalar
  x <- "thing"
  attr(x, "tag") <- "!thing"
  as.yaml(x)
#> [1] "!thing thing\n"

  # custom tag for sequence
  x <- 1:10
  attr(x, "tag") <- "!thing"
  as.yaml(x)
#> [1] "!thing\n- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n- 9\n- 10\n"

  # custom tag for mapping
  x <- data.frame(a = letters[1:5], b = letters[6:10])
  attr(x, "tag") <- "!thing"
  as.yaml(x)
#> [1] "!thing\na:\n- a\n- b\n- c\n- d\n- e\nb:\n- f\n- g\n- h\n- i\n- j\n"

  # custom tag for each element in a list
  x <- list(1, 2, 3)
  attr(x[[1]], "tag") <- "!a"
  attr(x[[2]], "tag") <- "!b"
  attr(x[[3]], "tag") <- "!c"
  as.yaml(x)
#> [1] "- !a 1.0\n- !b 2.0\n- !c 3.0\n"
```
