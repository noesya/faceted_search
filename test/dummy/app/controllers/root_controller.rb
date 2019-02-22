class RootController < ApplicationController
  def index
    @facets = Item::Facets.new params[:facets]
    @items = @facets.results.order(:title).page params[:page]
  end
end