# FacetedSearch
Short description and motivation.

## Usage
How to use my plugin.

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

Create a model defining your facets:

    class Item::Facets < FacetedSearch::Facets
      def define
        set_model Item.all
        search :title
        filter :products, find_by: :title
        filter :kinds
        filter :categories
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


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
