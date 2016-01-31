Solidus Simple Weight Calculator
==============================

Includes some shipping costs calculator for Solidus Commerce.

SimpleWeight
============
It's based on the total weight of the package.
You simply specify a weight/price table in the textarea like this:

```
5:10
10.5:15
100:50.5
```

This means:
- up to 5kg cost is 10
- up to 10.5kg cost is 15
- up to 100kg cost is 50.5
- over 100kg this shipping method doesn't apply

An optional handling fee can also be added.

ItemWeight
==========
Similar to `SimpleWeight`, but shipping cost is calculated on *each single item* of the package, and them summed up.
Useful if each item is shipped in different pack.


Usage
=====

Add to your Gemfile
```ruby
gem 'solidus_simple_weight_calculator'
```

Create a shipping method from the admin interface and choose the right calculator.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Credits
=======

Inspired by https://github.com/dancinglightning/spree-postal-service .


Copyright (c) 2015 Alessandro Lepore, Diego Franciosi - Released under the MIT License
