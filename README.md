CoffeeViews
=================
Inspired by [coffeebeans](https://github.com/markbates/coffeebeans) but with fixes:

 1. Doesn't compile coffeescript everytime in production
 2. Smart replacements for `<%=%>`

Use #to_json in safe mode

    <%=  x %> # replaced with `<%== (x).to_json %>`

Use raw mode in raw mode    
    
    <%== x %> # replaced with `<%== x %>`

Installation
------------
In your Gemfile:

    gem "coffee-views"

Dependencies
------------

This library depends on the `coffee-script` gem

Usage
-----

    # in create.js.coffee
    $("#item").html <%= render "user/card" %>
    
Note: There is no need to call `j` or `escape_javascipt` helpers. 
    
You can use `coffeeview:` embedded engine in [slim](http://slim-lang.com/) 

    h1 Say Hi
    coffeeview:
       alert <%= @some_view_string %>       