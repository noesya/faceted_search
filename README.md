# FacetedSearch
All you need to create a faceted search, as simple as possible

[![Maintainability](https://qlty.sh/badges/42826402-b514-4e5a-8181-f4e51cb24fbf/maintainability.svg)](https://qlty.sh/gh/noesya/projects/faceted_search)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'faceted_search'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install faceted_search
```

## Getting started

Add Bootstrap and Font Awesome to your `app/assets/stylesheets/application.sass`
```
@import 'bootstrap'
@import 'font-awesome-sprockets'
@import 'font-awesome'
```

Create a model defining your facets:

    class Item::Facets < FacetedSearch::Facets
      def initialize(params)
        super
        @model = Item.all
        filter_with_text :title
        filter_with_list :products, {
          find_by: :title,
          habtm: true
        }
        filter_with_list :kinds, {
          habtm: true
        }
        filter_with_list :style, {
          habtm: false
        }
        filter_with_tree :categories, {
          habtm: true,
          children_scope: Proc.new { |children|
            children.order(:title)
          }
        }
        filter_with_boolean :active
        # Other tree option, shows all values
        # filter_with_full_tree :categories, {
        #   habtm: true,
        #   children_scope: Proc.new { |children|
        #     children.order(:title)
        #   }
        # }

        # Other option, with searchable (SEO) categories
        filter_with_full_tree :categories, {
          habtm: true,
          searchable: true,
          path_pattern: Proc.new { |category_id|
            Rails.application.routes.url_helpers.category_path(category_id)
          }
        }

        # Filter with range input
        filter_with_range :distance, {
          min: 10,
          max: 200,
          step: 10,
          default_value: 50,
          hide_in_selected: true
        }
      end
    end

Warning: do not provide model with order, as it messes with the distinct used in the facet computations.

In your controller, use it:

    @facets = Item::Facets.new params[:facets]
    @items = @facets.results.order(:title).page params[:page]


In your view, do something like that (with bootstrap):

    <div class="row">
      <div class="col-md-3">
        <%= render 'faceted_search/facets', facets: @facets %>
      </div>
      <div class="col-md-9">
        <div class="row">
          <% @items.each do |item| %>
            <div class="col-md-4">
              <h2><%= item %></h2>
              <p>Products: <%= item.products.join(', ') %></p>
              <p>Categories: <%= item.categories.join(', ') %></p>
              <p>Kinds: <%= item.kinds.join(', ') %></p>
            </div>
          <% end %>
        </div>
      </div>
    </div>

If you need, you can add an anchor to the links:

    <%= render 'faceted_search/facets', facets: @facets, anchor: "#identifier" %>


## Note about full tree

Tagging must be logical in order to use filter_with_full_tree.
With these categories:

    Blues
        Chicago blues
        Delta Blues
        Memphis Blues
    Jazz
        Free jazz
        Swing
        Latin jazz

If something is tagged as "Delta blues", it MUST be tagged as "Blues" as well.
Otherwise, it creates very odd comportments (selecting "Blues" does not show the object, whereas it is "Delta blues").
There is no inference whatsoever, so the data MUST be clean.

The HTML code is ready for [Nestable2](https://github.com/RamonSmit/Nestable2) implementation. If you want to use this library, add the [CSS](https://github.com/RamonSmit/Nestable2/blob/master/dist/jquery.nestable.min.css) & [JS](https://github.com/RamonSmit/Nestable2/blob/master/dist/jquery.nestable.min.js) in your `vendor` folder and import them in `application.sass` & `application.js`.


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
