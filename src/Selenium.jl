module Selenium

import Base: get

using PyCall

function __init__()
	py"""
	from selenium import webdriver
	"""
end

include("constants.jl")

# Base

struct Driver
	o::PyObject
end

struct Element
	o::PyObject
end

export Driver, Element

chrome(args...) = Driver(py"webdriver.Chrome"(args...))
firefox(args...) = Driver(py"webdriver.Firefox"(args...))
ie(args...) = Driver(py"webdriver.Ie"(args...))

export chrome, firefox, ie

# Driver

find_element(browser::Driver, by::String, value::String) = Element(py"(lambda browser, by, value: browser.find_element(by, value))"(browser.o, by, value))
find_element_by_class_name(browser::Driver, class_name::String) = Element(py"(lambda browser, class_name: browser.find_element_by_class_name(class_name))"(browser.o, class_name))
find_element_by_css_selector(browser::Driver, css_selector::String) = Element(py"(lambda browser, css_selector: browser.find_element_by_css_selector(css_selector))"(browser.o, css_selector))
find_element_by_id(browser::Driver, id::String) = Element(py"(lambda browser, id: browser.find_element_by_id(id))"(browser.o, id))
find_element_by_link_text(browser::Driver, link_text::String) = Element(py"(lambda browser, link_text: browser.find_element_by_link_text(link_text))"(browser.o, link_text))
find_element_by_name(browser::Driver, name::String) = Element(py"(lambda browser, name: browser.find_element_by_name(name))"(browser.o, name))
find_element_by_partial_link_text(browser::Driver, link_text::String) = Element(py"(lambda browser, link_text: browser.find_element_by_partial_link_text(link_text))"(browser.o, link_text))
find_element_by_tag_name(browser::Driver, tag_name::String) = Element(py"(lambda browser, tag_name: browser.find_element_by_tag_name(tag_name))"(browser.o, tag_name))
find_element_by_xpath(browser::Driver, xpath::String) = Element(py"(lambda browser, xpath: browser.find_element_by_xpath(xpath))"(browser.o, xpath))

get(browser::Driver, url::String) = py"(lambda browser, url: browser.get(url))"(browser.o, url)

title(browser::Driver) = py"(lambda browser: browser.title)"(browser.o)
quit(browser::Driver) = py"(lambda browser: browser.quit())"(browser.o)

# Element

find_element(elem::Element, by::String, value::String) = Element(py"(lambda elem, by, value: elem.find_element(by, value))"(elem.o, by, value))
find_element_by_class_name(elem::Element, class_name::String) = Element(py"(lambda elem, class_name: elem.find_element_by_class_name(class_name))"(elem.o, class_name))
find_element_by_css_selector(elem::Element, css_selector::String) = Element(py"(lambda elem, css_selector: elem.find_element_by_css_selector(css_selector))"(elem.o, css_selector))
find_element_by_id(elem::Element, id::String) = Element(py"(lambda elem, id: elem.find_element_by_id(id))"(elem.o, id))
find_element_by_link_text(elem::Element, link_text::String) = Element(py"(lambda elem, link_text: elem.find_element_by_link_text(link_text))"(elem.o, link_text))
find_element_by_name(elem::Element, name::String) = Element(py"(lambda elem, name: elem.find_element_by_name(name))"(elem.o, name))
find_element_by_partial_link_text(elem::Element, link_text::String) = Element(py"(lambda elem, link_text: elem.find_element_by_partial_link_text(link_text))"(elem.o, link_text))
find_element_by_tag_name(elem::Element, tag_name::String) = Element(py"(lambda elem, tag_name: elem.find_element_by_tag_name(tag_name))"(elem.o, tag_name))
find_element_by_xpath(elem::Element, xpath::String) = Element(py"(lambda elem, xpath: elem.find_element_by_xpath(xpath))"(elem.o, xpath))

click(elem::Element) = py"(lambda elem: elem.click())"(elem.o)
send_keys(elem::Element, value...) = py"(lambda elem, *value: elem.send_keys(*value))"(elem.o, value...)

# Exports

export find_element, find_element_by_class_name, find_element_by_css_selector, find_element_by_id, find_element_by_link_text, find_element_by_name, find_element_by_partial_link_text, find_element_by_tag_name, find_element_by_xpath

export get, title, quit

export click, send_keys

end
