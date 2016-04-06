class SealsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      add_breadcrumb Deed.model_name.human(count: 1)
      add_breadcrumb @deed.title, deed_path(@deed)
      @seals = @deed.seals
    else
      @seals = Seal.all
    end

    add_breadcrumb Seal.model_name.human(count: 2), :seals_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @seal = Seal.find_by id: params[:id]
    respond_to :js
  end

  private
  def seal_params
    params.require(:seal).permit(:title, :notes)
  end
end
