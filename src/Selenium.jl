module Selenium

import Base: get, parent, size

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

struct ChromeOptions
	o::PyObject
end

struct FirefoxOptions
	o::PyObject
end

function chrome(;options::ChromeOptions=ChromeOptions(Nothing))
	kwargs::Array{Any} = []
	py_args::Array{String} = []
	
	if options.o != Nothing
		push!(kwargs, options.o)
		push!(py_args, "options")
	end

	code = "(lambda $(join(py_args, ",")): webdriver.Chrome($(join(map(a -> "$a=$a", py_args), ","))))"
	Driver(py"$$code"(kwargs...))
end

function firefox(;options::FirefoxOptions=FirefoxOptions(Nothing))
	kwargs::Array{Any} = []
	py_args::Array{String} = []
	
	if options.o != Nothing
		push!(kwargs, options.o)
		push!(py_args, "options")
	end
	
	code = "(lambda $(join(py_args, ",")): webdriver.Firefox($(join(map(a -> "$a=$a", py_args), ","))))"
	Driver(py"$$code"(kwargs...))
end

export Driver, Element, ChromeOptions, FirefoxOptions, chrome, firefox

# Options

chrome_options() = ChromeOptions(py"webdriver.ChromeOptions"())
firefox_options() = FirefoxOptions(py"webdriver.FirefoxOptions"())

add_argument(options::ChromeOptions, argument::String) = py"(lambda options, argument: options.add_argument(argument))"(options.o, argument)
add_encoded_extension(options::ChromeOptions, extension::String) = py"(lambda options, extension: options.add_encoded_extension(extension))"(options.o, extension)
add_experimental_option(options::ChromeOptions, name::String, value::String) = py"(lambda options, name, value: options.add_experimental_option(name, value))"(options.o, name, value)
add_extension(options::ChromeOptions, extension::String) = py"(lambda options, extension: options.add_extension(extension))"(options.o, extension)
set_capability(options::ChromeOptions, name::String, value::String) = py"(lambda options, name, value: options.set_capability(name, value))"(options.o, name, value)
set_headless(options::ChromeOptions, headless::Bool=true) = py"(lambda options, headless: options.set_headless(headless))"(options.o, headless)
to_capabilities(options::ChromeOptions) = py"(lambda options: options.to_capabilities())"(options.o)

arguments(options::ChromeOptions) = py"(lambda options: options.arguments)"(options.o)
binary_location(options::ChromeOptions) = py"(lambda options: options.binary_location)"(options.o)
capabilities(options::ChromeOptions) = py"(lambda options: options.capabilities)"(options.o)
debugger_address(options::ChromeOptions) = py"(lambda options: options.debugger_address)"(options.o)
experimental_options(options::ChromeOptions) = py"(lambda options: options.experimental_options)"(options.o)
extensions(options::ChromeOptions) = py"(lambda options: options.extensions)"(options.o)
headless(options::ChromeOptions) = py"(lambda options: options.headless)"(options.o)

add_argument(options::FirefoxOptions, argument::String) = py"(lambda options, argument: options.add_argument(argument))"(options.o, argument)
set_capability(options::FirefoxOptions, name::String, value::String) = py"(lambda options, name, value: options.set_capability(name, value))"(options.o, name, value)
set_headless(options::FirefoxOptions, headless::Bool=true) = py"(lambda options, headless: options.set_headless(headless))"(options.o, headless)
set_preference(options::FirefoxOptions, name::String, value::String) = py"(lambda options, name, value: options.set_preference(name, value))"(options.o, name, value)
to_capabilities(options::FirefoxOptions) = py"(lambda options: options.to_capabilities())"(options.o)

arguments(options::FirefoxOptions) = py"(lambda options: options.arguments)"(options.o)
binary(options::FirefoxOptions) = py"(lambda options: options.binary)"(options.o)
binary_location(options::FirefoxOptions) = py"(lambda options: options.binary_location)"(options.o)
capabilities(options::FirefoxOptions) = py"(lambda options: options.capabilities)"(options.o)
headless(options::FirefoxOptions) = py"(lambda options: options.headless)"(options.o)
preferences(options::FirefoxOptions) = py"(lambda options: options.preferences)"(options.o)
profile(options::FirefoxOptions) = py"(lambda options: options.profile)"(options.o)
proxy(options::FirefoxOptions) = py"(lambda options: options.proxy)"(options.o)

export chrome_options, firefox_options, add_argument, add_encoded_extension, add_experimental_option, add_extension, set_capability, set_headless, to_capabilities, arguments, binary_location, capabilities, debugger_address, experimental_options, extensions, headless, set_preference, binary, preferences, profile, proxy

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

implicitly_wait(browser::Driver, secs::Int64) = py"(lambda browser, secs: browser.implicitly_wait(secs))"(browser.o, secs)
title(browser::Driver) = py"(lambda browser: browser.title)"(browser.o)
quit(browser::Driver) = py"(lambda browser: browser.quit())"(browser.o)

export find_element, find_element_by_class_name, find_element_by_css_selector, find_element_by_id, find_element_by_link_text, find_element_by_name, find_element_by_partial_link_text, find_element_by_tag_name, find_element_by_xpath
export get, implicitly_wait, title, quit

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

get_attribute(elem::Element, name::String) = py"(lambda elem, name: elem.get_attribute(name))"(elem.o, name)
get_property(elem::Element, name::String) = py"(lambda elem, name: elem.get_property(name))"(elem.o, name)
is_displayed(elem::Element) = py"(lambda elem: elem.is_displayed())"(elem.o)
is_enabled(elem::Element) = py"(lambda elem: elem.is_enabled())"(elem.o)
is_selected(elem::Element) = py"(lambda elem: elem.is_selected())"(elem.o)
value_of_css_property(elem::Element, name::String) = py"(lambda elem, name: elem.value_of_css_property(name))"(elem.o, name)

id(elem::Element) = py"(lambda elem: elem.id)"(elem.o)
location(elem::Element) = py"(lambda elem: elem.location)"(elem.o)
location_once_scrolled_into_view(elem::Element) = py"(lambda elem: elem.location_once_scrolled_into_view)"(elem.o)
parent(elem::Element) = py"(lambda elem: elem.parent)"(elem.o)
rect(elem::Element) = py"(lambda elem: elem.rect)"(elem.o)
screenshot_as_base64(elem::Element) = py"(lambda elem: elem.screenshot_as_base64)"(elem.o)
screenshot_as_png(elem::Element) = py"(lambda elem: elem.screenshot_as_png)"(elem.o)
size(elem::Element) = py"(lambda elem: elem.size)"(elem.o)
tag_name(elem::Element) = py"(lambda elem: elem.tag_name)"(elem.o)
text(elem::Element) = py"(lambda elem: elem.text)"(elem.o)

clear(elem::Element) = py"(lambda elem: elem.clear())"(elem.o)
click(elem::Element) = py"(lambda elem: elem.click())"(elem.o)
screenshot(elem::Element, filename::String) = py"(lambda elem, filename: elem.screenshot(filename))"(elem.o, filename)
send_keys(elem::Element, value...) = py"(lambda elem, *value: elem.send_keys(*value))"(elem.o, value...)
submit(elem::Element) = py"(lambda elem: elem.submit())"(elem.o)

(==)(a::Element, b::Element) = py"(lambda a, b: a == b)"(a.o, b.o)

export get_attribute, get_property, is_displayed, is_enabled, is_selected, value_of_css_property, id, location, location_once_scrolled_into_view, parent, rect, screenshot_as_base64, screenshot_as_png, size, tag_name, text, clear, click, screenshot, send_keys, submit

end
