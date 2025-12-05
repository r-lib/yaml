# Changelog

## yaml (development version)

- Fixes for C API compliance.

- Switched from `CHANGELOG` to `NEWS.md`.

## yaml 2.3.10

CRAN release: 2024-07-26

- Added necessary includes for `stdio.h` and `stddef.h`.

## yaml 2.3.9

CRAN release: 2024-07-05

- Edited documentation.

## yaml 2.3.8

CRAN release: 2023-12-11

- Added `verbatim_logical` helper function.

## yaml 2.3.7

CRAN release: 2023-01-23

- clang deprecated `sprintf`. Changed in included clib to `snprintf`.

## yaml 2.3.6

CRAN release: 2022-10-18

- C deprecated functions with no prototypes, these were added.

## yaml 2.3.5

CRAN release: 2022-02-21

- Patch to put back in libyaml modifications that `as.yaml` relied on.

## yaml 2.3.4

CRAN release: 2022-02-17

- Added `read_yaml` parameter `readLines.warn` that defaults to `TRUE`
  for overriding warnings about incomplete files.

## yaml 2.3.3

- Fixed Bug [\#99](https://github.com/lib/r-yaml/issues/99), support for
  `BUILTINSXP` functions as handlers.

## yaml 2.3.2

- Removed some code that got reverted in the libyaml 0.2.5 merge at
  2.2.4 release.

## yaml 2.3.1

- Added omap support for output using proper tag.

## yaml 2.3.0

- Made `eval.expr` default to `FALSE`.

## yaml 2.2.4

- Updated libyaml code from 0.2.5.

## yaml 2.2.3

- Added attribute quote support for strings
  ([\#72](https://github.com/lib/r-yaml/issues/72),
  [\#109](https://github.com/lib/r-yaml/issues/109)).

## yaml 2.2.2

CRAN release: 2022-01-25

- Changed maintainer from Jeremy Stephens to Shawn Garbett.
- Moved Git repository to <https://github.com/vubiostat/r-yaml>.

## yaml 2.2.1

CRAN release: 2020-02-01

- Added `merge.precedence` option to `yaml.load`.
- Fixed improper handling of explicit `!bool` tag (reported by Luke
  Goodsell).
- Fixed memory issue flagged by valgrind.
- Updated LibYAML to 0.2.2.
- Fixed some `-Wall` warnings to appease CRAN.

## yaml 2.2.0

CRAN release: 2018-07-25

- Added custom handlers to `as.yaml`.
- Added processing of ‘verbatim’ class in `as.yaml`.
- Added processing of ‘tag’ class in `as.yaml`.
- Changed examples/tests to write to tempfiles to appease CRAN.
- Fixed `as.yaml` representation of very small negative floating point
  numbers (reported by Ryan Welch).
- Properly ignore a map key that would override a key from a merged map
  (reported by Bradley Saul).
- Gracefully fail compilation if GCC fast-math flag is enabled (reported
  by Dmitriy Selivanov).
- Switched from testthat to RUnit for unit testing since RUnit has fewer
  dependencies and does not require compilation.

## yaml 2.1.19

CRAN release: 2018-05-01

- Fixed unserialization issues with `int#base60` tag (reported by Nancy
  Irisarri).
- Added `eval.expr` option to `yaml.load` function.
- Fixed issue with `error.label` argument (patch by Gregory R. Warnes).
- Fixed a few garbage collection protection issues.

## yaml 2.1.18

CRAN release: 2018-03-08

- Fixed protection stack bugs (reported by Rich FitzJohn).

## yaml 2.1.17

CRAN release: 2018-02-27

- Rewrote parsing functionality using pairlists instead of a
  self-managed protection stack in order to appease rchk.
- Use `MARK_NOT_MUTABLE` instead of `SET_NAMED`, which is deprecated.
- Show warning when duplicate map key is ignored during a merge.

## yaml 2.1.16

CRAN release: 2017-12-12

- Fixed error checking bug regarding number conversions.

## yaml 2.1.15

CRAN release: 2017-12-01

- Improved handling of UTF-8 encoded files.
- Added Github URL to description file.
- Added `read_yaml` and `write_yaml` convenience functions.
- Added `error.label` parameter to `yaml.load` and `yaml.load_file`.
- Recognize floating point numbers without leading 0.
- Fixed nested list issue.
- Show warning for integer/real overflow.

## yaml 2.1.14

CRAN release: 2016-11-12

- Marked character input/output as UTF-8 (patch submitted by Yihui Xie).
- Updated LibYAML to 0.1.7.

## yaml 2.1.13

CRAN release: 2014-06-12

- Fixed integer overflow issue.
- Explicitly cast pointers from char to `yaml_char_t`, and vice versa.

## yaml 2.1.12

CRAN release: 2014-06-11

- Properly emit factors with NAs (bug submitted by Jenny Bryan).
- Updated LibYAML to 0.1.6.

## yaml 2.1.11

CRAN release: 2014-03-15

- Updated LibYAML to 0.1.5.

## yaml 2.1.10

CRAN release: 2014-01-04

- Properly escape names in data frames and lists (bug submitted by Paul
  Hodor).
- Removed extra digit in Windows when formatting exponential numbers.

## yaml 2.1.9

CRAN release: 2013-12-29

- CRAN maintainers changed `memcpy` to `memmove`.

## yaml 2.1.8

CRAN release: 2013-08-23

- Properly emit and consume numeric values in scientific notation (bug
  submitted by Gergely Daróczi).
- Added ‘precision’ argument to `as.yaml` to control how many digits are
  printed when emitting.

## yaml 2.1.7

CRAN release: 2013-03-05

- Properly emit and consume special values: `Inf`, `-Inf`, `NaN`, `NA`,
  `TRUE`, and `FALSE` (bug submitted by Richard Cotton).
  - `Inf` is emitted as `.inf`.
  - `-Inf` as `-.inf`.
  - `NaN` as `.nan`.
  - `TRUE` is now emitted as `yes`, and `FALSE` as `no`.
- Because the YAML specification does not specify how to handle NA
  values, the various NA types are emitted as follows:
  - `NA`: `.na`
  - `NA_real_`: `.na.real`
  - `NA_integer_`: `.na.integer`
  - `NA_character_`: `.na.character`

## yaml 2.1.6

CRAN release: 2013-01-18

- Added `unicode` option to
  [`as.yaml()`](https://yaml.r-lib.org/reference/as.yaml.md) (bug
  submissions by Gergely Daróczi and Aleksandar Blagotić).

## yaml 2.1.5

CRAN release: 2012-11-15

- Fixed [`yaml.load()`](https://yaml.r-lib.org/reference/yaml.load.md)
  ignoring explicit quotes around strings (bug submitted by Jonas
  Zimmermann).
- Fixed [`as.yaml()`](https://yaml.r-lib.org/reference/as.yaml.md) not
  quoting strings that need to be quoted.

## yaml 2.1.4

CRAN release: 2012-04-05

- Replaced `lang5()` function for backwards compatibility with R \<
  2.12.0 (bug submitted by Philipp Hofmann).

## yaml 2.1.3

CRAN release: 2012-01-31

- Fixed [`as.yaml()`](https://yaml.r-lib.org/reference/as.yaml.md)
  converting numeric vectors incorrectly (bug submitted by Markus
  Göker).

## yaml 2.1.2

CRAN release: 2012-01-17

- Fixed multiple anchor bug (bug submitted by apshaar).

## yaml 2.1.1

CRAN release: 2011-12-08

- Removed redundant yaml-package help page.
- Fixed solaris compilation error.
- Removed printf/assert symbols from the compiled library.

## yaml 2.1.0

CRAN release: 2011-12-03

- Rewrote `as.yaml` in C (using libyaml’s emitter).
- Removed the `pre.indent` option to `as.yaml`, mainly because libyaml
  doesn’t support pre-indention and I’m not sure the option is useful
  anymore; will revisit if requested.

## yaml 2.0.0

CRAN release: 2011-11-12

- Switched from the Syck parser to the libyaml (0.1.4) parser.
- Sequences of sequences no longer collapse when they contain the same
  type; ex: `yaml.load("[1, [2, 3], 4]")` returns
  `list(1L, c(2L, 3L), 4L)`.

## yaml 1.2.0

CRAN release: 2011-06-17

- Added support for loading R expressions (using the `!expr` tag).
- Added multiline string support.
- Added support for nameless lists in `as.yaml` (converts to a
  sequence).

## yaml 1.1.0

CRAN release: 2009-09-12

- Added support for omaps.
- Added `yaml.load_file` function to read from files/connections.
- Using `format` instead of `as.character` now in `as.yaml.default`.

## yaml 1.0.2

CRAN release: 2009-08-26

- Fixed `as.yaml` bug where a nested empty list wasn’t converted
  correctly.

## yaml 1.0.1

CRAN release: 2008-11-14

- `yaml.load` will now load empty documents (bug submitted by Jeff
  Klingner).
- `as.yaml` will return `'[]'` for empty objects (patch submitted by
  Brendan O’Connor).
- `as.yaml` will now create valid YAML for a list that contains a list
  of length one (bug submitted by Gabor Grothendieck).
