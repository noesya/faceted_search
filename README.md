# FacetedSearch
All you need to create a faceted search, as simple as possible

[![Maintainability](https://api.codeclimate.com/v1/badges/70579009d11cfa0d7cac/maintainability)](https://codeclimate.com/github/lespoupeesrusses/faceted_search/maintainability)

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
        filter_with_tree :categories, {
          habtm: true,
          children_scope: Proc.new { |children|
            children.order(:title)
          }
        }
        # Other tree option, shows all values
        # filter_with_full_tree :categories, {
        #   habtm: true,
        #   children_scope: Proc.new { |children|
        #     children.order(:title)
        #   }
        # }
      end
    end

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


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
