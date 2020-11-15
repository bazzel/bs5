# Bs5

This is a Ruby on Rails engine to include [Bootstrap 5](https://v5.getbootstrap.com/).

[![Gem Version](https://badge.fury.io/rb/bs5.svg)](https://badge.fury.io/rb/bs5)

## Usage

How to use my plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bs5'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install bs5
```

## Configuration

Run the following command to setup your project to use Bootstrap 5.

    $ rails generate bs5:install
    
## Components

### Alert 🖌

```
<%= render Bs5::AlertComponent.new do %>
  A simple primary alert—check it out!
<%- end %>
```

```
<%= render Bs5::AlertComponent.new(type: :warning, is_dismissable: true) do %>
  <strong>Holy guacamole!</strong> You should check in on some of those fields below.
<%- end %>
```

## Previewing components

* http://localhost:3000/rails/view_components

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
