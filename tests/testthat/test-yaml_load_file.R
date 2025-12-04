check_named_list_equals <- function(x, y) {
  expect_equal(class(x), class(y))
  expect_equal(length(x), length(y))

  ns <- sort(names(x))
  expect_equal(ns, sort(names(y)))
  for (n in ns) {
    expect_equal(x[[n]], y[[n]])
  }
}

test_that("reading from a connection works", {
  filename <- tempfile()
  cat("foo: 123", file = filename, sep = "\n")
  foo <- file(filename, "r")
  x <- yaml.load_file(foo)
  close(foo)
  unlink(filename)
  expect_equal(x$foo, 123L)
})

test_that("reading from specified filename works", {
  filename <- tempfile()
  cat("foo: 123", file = filename, sep = "\n")
  x <- yaml.load_file(filename)
  unlink(filename)
  expect_equal(x$foo, 123L)
})

test_that("reading a complicated document works", {
  filename <- test_path("test.yml")
  x <- yaml.load_file(filename)
  expected <- list(
    foo = list(one = 1, two = 2),
    bar = list(three = 3, four = 4),
    baz = list(list(one = 1, two = 2), list(three = 3, four = 4)),
    quux = list(one = 1, two = 2, three = 3, four = 4, five = 5, six = 6),
    corge = list(
      list(one = 1, two = 2, three = 3, four = 4, five = 5, six = 6),
      list(
        xyzzy = list(one = 1, two = 2, three = 3, four = 4, five = 5, six = 6)
      )
    )
  )
  expect_equal(x, expected)
})

test_that("expressions are not implicitly converted with warning", {
  filename <- tempfile()
  cat("!expr 123 + 456", file = filename, sep = "\n")
  foo <- file(filename, "r")
  expect_warning(x <- yaml.load_file(foo), "Evaluating R expressions")
  close(foo)
  unlink(filename)
  expect_equal(class(x), "character")
  expect_equal(x, "123 + 456")
})

test_that("expressions are explicitly converted without warning", {
  filename <- tempfile()
  cat("!expr 123 + 456", file = filename, sep = "\n")
  foo <- file(filename, "r")
  expect_no_warning({
    x <- yaml.load_file(foo, eval.expr = TRUE)
  })
  close(foo)
  unlink(filename)
  expect_equal(class(x), "numeric")
  expect_equal(x, 579)
})

test_that("expressions are unconverted", {
  filename <- tempfile()
  cat("!expr 123 + 456", file = filename, sep = "\n")
  foo <- file(filename, "r")
  x <- yaml.load_file(foo, eval.expr = FALSE)
  close(foo)
  unlink(filename)

  expect_equal(class(x), "character")
  expect_equal(x, "123 + 456")
})

test_that("merge specification example with merge override", {
  filename <- test_path("merge.yml")
  x <- yaml.load_file(filename, merge.precedence = "override")
  expected <- list(x = 1, y = 2, r = 10, label = "center/big")
  check_named_list_equals(x[[5]], expected)
  check_named_list_equals(x[[6]], expected)
  check_named_list_equals(x[[7]], expected)
  check_named_list_equals(x[[8]], expected)
})
