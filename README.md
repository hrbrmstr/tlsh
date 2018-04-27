
# tlsh

Local Sensitivity Hashing Using the ‘Trend Micro’ ‘TLSH’ Implementation

## Description

‘Trend Micro’ provides an open source library
<https://github.com/trendmicro/tlsh/> for local sensitivity hashing.
Methods are provided to compute and compare hashes from character/byte
streams.

## References

  - Jonathan Oliver, Chun Cheng and Yanggui Chen, “[TLSH - A Locality
    Sensitive
    Hash](https://github.com/trendmicro/tlsh/blob/master/TLSH_CTC_final.pdf)”
    4th Cybercrime and Trustworthy Computing Workshop, Sydney, November
    2013
  - Jonathan Oliver, Scott Forman and Chun Cheng, “[Using Randomization
    to Attack Similarity
    Digests](https://github.com/trendmicro/tlsh/blob/master/Attacking_LSH_and_Sim_Dig.pdf)”
    Applications and Techniques in Information Security. Springer Berlin
    Heidelberg, 2014. 199-210.
  - Jonathan Oliver and Jayson Pryde’s [Trend Micro Blog
    Post](http://blog.trendmicro.com/trendlabs-security-intelligence/smart-whitelisting-using-locality-sensitive-hashing/)

## TODO

  - \[ \] File input
  - \[ \] Docs
  - \[ \] Tests
  - \[ \] Reference class-backed DSL

## What’s Inside The Tin

The following functions are implemented:

## Installation

``` r
devtools::install_github("hrbrmstr/tlsh")
```

## Usage

``` r
library(tlsh)

# current verison
packageVersion("tlsh")
```

    ## [1] '0.1.0'

## Example

  - `index.html` is a static copy of a blog main page with a bunch of
    `<div>`s with article snippets
  - `index1.html` is the same file as `index.htmnl` with a changed cache
    timestamp at the end
  - `index2.html` is the same file as `index.html` with one article
    snippet removed
  - `RMacOSX-FAQ.html` is the CRAN ‘R for Mac OS X
FAQ’

<!-- end list -->

``` r
doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
doc2 <- as.character(xml2::read_html(system.file("extdat", "index1.html", package="tlsh")))
doc3 <- as.character(xml2::read_html(system.file("extdat", "index2.html", package="tlsh")))
doc4 <- as.character(xml2::read_html(system.file("extdat", "RMacOSX-FAQ.html", package="tlsh")))

# generate hashes
 
(h1 <- tlsh_simple_hash(doc1))
```

    ## [1] "B253F9F3168DC8354B2363E2A585771CD25A803BCEA099C1FBED54ACA790EB5B137346"

``` r
(h2 <- tlsh_simple_hash(doc2))
```

    ## [1] "6153E8F3168DC8355B2363E2A585771CD26A803BCEA099C1FBED44AC9790EB5B137346"

``` r
(h3 <- tlsh_simple_hash(doc3))
```

    ## [1] "6443E8F3168DC8355B6262F2A9C5771CD25A802BCEA099C1FBED54AC9780FF4A137346"

``` r
(h4 <- tlsh_simple_hash(doc4))
```

    ## [1] "B8B3A52F93C0233E0F1216576F192FA812FD5C7EA3802188B557C67F8712D9A47666BB"

``` r
# compute distance

tlsh_simple_diff(h1, h2)
```

    ## [1] 7

``` r
tlsh_simple_diff(h1, h3)
```

    ## [1] 18

``` r
tlsh_simple_diff(h1, h4)
```

    ## [1] 334

### Reference class machinations

Just a demo for testing purposes. This will be abstraced by a DSL.

``` r
x <- new(Tlsh$tlsh_r)

x$lib_version()
```

    ## [1] "3.9.1 compact hash 1 byte checksum sliding_window=5"

``` r
doc1 <- charToRaw(as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh"))))

x$all_in_one(doc1)
```

    ## [1] "B253F9F3168DC8354B2363E2A585771CD25A803BCEA099C1FBED54ACA790EB5B137346"

``` r
x$update(doc1)
x$final(0)
x$is_valid()
```

    ## [1] TRUE

``` r
x$get_hash()
```

    ## [1] "B253F9F3168DC8354B2363E2A585771CD25A803BCEA099C1FBED54ACA790EB5B137346"

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
