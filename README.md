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

- [Accordion](#accordion) ✅
- [Alert](#alert) ✅
- [Badge](#badge) ✅
- Breadcrumb
- Buttons
- Button group
- Card
- Carousel
- [Close button](#close-button) ✅
- Collapse
- Dropdowns
- List group
- Modal
- Nav & tabs
- Navbar
- Pagination
- Popovers
- Progress
- Scrollspy
- Spinners
- Toasts
- Tooltips


### [Accordion](https://v5.getbootstrap.com/docs/5.0/components/accordion/)

```
<%= bs5_accordion do |accordion| %>
  <% accordion.slot(:item, title: 'Accordion Item #1', collapsed: false) do %>
    <strong>This is the first item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
  <% end %>
  <% accordion.slot(:item, title: 'Accordion Item #2') do %>
    <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
  <% end %>
  <% accordion.slot(:item, title: 'Accordion Item #3') do %>
    <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
  <% end %>
<%- end %>
```

```
<%= bs5_accordion(flush: true) do |accordion| %>
  <% accordion.slot(:item, title: 'Accordion Item #1') do %>
    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
  <% end %>
  <% accordion.slot(:item, title: 'Accordion Item #2') do %>
    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
  <% end %>
  <% accordion.slot(:item, title: 'Accordion Item #3') do %>
    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
  <% end %>
<%- end %>
```

### [Alert](https://v5.getbootstrap.com/docs/5.0/components/alerts/)

```
<%= bs5_alert do %>
  A simple primary alert—check it out!
<%- end %>
```

```
<%= bs5_alert(style: :warning, is_dismissable: true) do %>
  <strong>Holy guacamole!</strong> You should check in on some of those fields below.
<%- end %>
```

### [Badge](https://v5.getbootstrap.com/docs/5.0/components/badge/)

```
<%= bs5_badge(text: 'New') %>
```

```
<%= bs5_badge(text: 'Warning', style: :warning) %>
```

```
<%= bs5_badge(text: 'Danger', style: :danger, pill: true) %>
```


### [Breadcrumb](https://v5.getbootstrap.com/docs/5.0/components/breadcrumb/)

### [Button](https://v5.getbootstrap.com/docs/5.0/components/buttons/)

### [Close button](https://v5.getbootstrap.com/docs/5.0/components/close-button/)

```
<%= bs5_close_button %>
```

```
<%= bs5_close_button(disabled: true) %>
```

```
<%= bs5_close_button(white: true) %>
```

```
<%= bs5_close_button(data: { controller: 'hello', action: "click->hello#greet }) %>
```

## Previewing components

- http://localhost:3000/rails/view_components

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
