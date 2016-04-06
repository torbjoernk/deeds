class PlacesController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      add_breadcrumb Deed.model_name.human(count: 1), deeds_path
      add_breadcrumb @deed.title, deed_path(@deed)
      @places = @deed.places
    else
      @places = Place.all
    end

    add_breadcrumb Place.model_name.human(count: 2), places_path

    respond_to do |format|
      format.html { render 'places/index' }
      format.js   { render 'places/index' }
    end
  end

  def show
    @place = Place.find_by id: params[:id]
    respond_to :js
  end

  def new
    @place = Place.new
    respond_to :js
  end

  def edit
    @place = Place.find_by id: params[:id]
    edit_subaction 'places/edit', 'places/form/refresh'
  end

  def create
    @place = Place.create!(place_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Place.model_name.human(count: 1), id: @place.id)
    redirect_to places_path
  end

  def update
    @place = Place.find_by id: params[:id]
    @place.update!(place_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Place.model_name.human(count: 1), id: @place.id)
    redirect_to places_path
  end

  def destroy
    destroy_entity_of Place, params
    redirect_to places_path
  end

  private
  def place_params
    params.require(:place).permit(:title, :notes)
  end
end
