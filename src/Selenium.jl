module Selenium

using PyCall

function __init__()
	py"""
	from selenium import webdriver
	"""
end

chrome(args...) = py"webdriver.Chrome"(args...)
firefox(args...) = py"webdriver.Firefox"(args...)
ie(args...) = py"webdriver.Ie"(args...)

get(browser::PyObject, url::String) = py"(lambda browser, url: browser.get(url))"(browser, url)
title(browser::PyObject) = py"(lambda browser: browser.title)"(browser)

export chrome, firefox, ie, get, title

end
