module Selenium

import Base: get

using PyCall

function __init__()
	py"""
	from selenium import webdriver
	"""
end

include("constants.jl")

struct Driver
	o::PyObject
end

chrome(args...) = Driver(py"webdriver.Chrome"(args...))
firefox(args...) = Driver(py"webdriver.Firefox"(args...))
ie(args...) = Driver(py"webdriver.Ie"(args...))

get(browser::Driver, url::String) = py"(lambda browser, url: browser.get(url))"(browser.o, url)
title(browser::Driver) = py"(lambda browser: browser.title)"(browser.o)
quit(browser::Driver) = py"(lambda browser: browser.quit())"(browser.o)

export chrome, firefox, ie, get, title, quit

end
