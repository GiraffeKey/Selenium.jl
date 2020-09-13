# Selenium.jl

This package provides Julia bindings to Selenium's Python package. Not much has been covered so far.

## Installation

Install selenium:

`pip3 install selenium`

Download the respective drivers:

|              |                                                                       |
|--------------|-----------------------------------------------------------------------|
| **Chrome**:  | https://chromedriver.chromium.org/downloads                           |
| **Edge**:    | https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/ |
| **Firefox**: | https://github.com/mozilla/geckodriver/releases                       |
| **Safari**:  | https://webkit.org/blog/6900/webdriver-support-in-safari-10/          |

## TODO

[ ] Full coverage of Selenium's API
[ ] Write tests
[ ] Utilize the strengths of Julia more effectively (instead of just directly ripping from the Python API)
[ ] Minimize calls to other languages

## Usage

```julia
using Selenium

browser = firefox()

get(browser, "http://yahoo.com")

(println ∘ title)(browser)
```
