class StylesController < ApplicationController
  before_action :set_style, only: %i[ show edit update destroy ]

  # GET /styles
  def index
    @styles = Style.all
  end

  # GET /styles/1
  def show
  end

  # GET /styles/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles
  def create
    @style = Style.new(style_params)

    if @style.save
      redirect_to @style, notice: "Style was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /styles/1
  def update
    if @style.update(style_params)
      redirect_to @style, notice: "Style was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /styles/1
  def destroy
    @style.destroy
    redirect_to styles_url, notice: "Style was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def style_params
      params.require(:style).permit(:title)
    end
end
