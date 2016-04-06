class SealsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @seals = Seal.all

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

  def new
    @seal = Seal.new
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
    end
    respond_to :js
  end

  def edit
    @seal = Seal.find_by id: params[:id]
    edit_subaction 'seals/edit', 'seals/form/refresh'
  end

  def create
    @seal = Seal.create!(seal_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Seal.model_name.human(count: 1), id: @seal.id)
    if @seal.deed
      redirect_to deed_path(@seal.deed)
    else
      redirect_to seals_path
    end
  end

  def update
    @seal = Seal.find_by id: params[:id]
    @seal.update!(seal_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Seal.model_name.human(count: 1), id: @seal.id)
    redirect_to seals_path
  end

  def destroy
    destroy_entity_of Seal, params
    redirect_to seals_path
  end

  private
  def seal_params
    params.require(:seal).permit(:title, :material, :attachment_type, :notes, :deed_id)
  end
end
