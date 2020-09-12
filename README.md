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

## Usage

```julia
using Selenium

browser = firefox()

get(browser, "http://yahoo.com")

println(title(browser))
```
