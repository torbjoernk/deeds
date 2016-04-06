class ReferencesController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      add_breadcrumb Deed.model_name.human(count: 1)
      add_breadcrumb @deed.title, deed_path(@deed)
      @references = @deed.references
    elsif params.has_key? :seal_id
      @seal = Seal.find_by id: params[:seal_id]
      add_breadcrumb Seal.model_name.human(count: 1)
      add_breadcrumb @seal.title
      @references = @seal.references
    else
      @references = Reference.all
    end

    add_breadcrumb Reference.model_name.human(count: 2), :references_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @reference = Reference.find_by id: params[:id]
    respond_to :js
  end

  def new
    @reference = Reference.new
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
    end
    respond_to :js
  end

  def edit
    @reference = Reference.find_by id: params[:id]
    edit_subaction 'references/edit', 'references/form/refresh'
  end

  def create
    @reference = Reference.new(reference_params)
    if params[:reference].has_key? :deed_id
      @deed = Deed.find_by id: params[:reference][:deed_id]
      @reference.deeds << @deed
    elsif params[:reference].has_key? :seal_id
      @seal = Seal.find_by id: params[:reference][:seal_id]
      @reference.seals << @seal
    end
    @reference.save!
    flash[:success] = t('views.flash.created_entity',
                        what: Reference.model_name.human(count: 1), id: @reference.id)
    redirect_to references_path
  end

  def update
    @reference = Reference.find_by id: params[:id]
    @reference.update!(reference_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Reference.model_name.human(count: 1), id: @reference.id)
    redirect_to references_path
  end

  def destroy
    destroy_entity_of Reference, params
    redirect_to references_path
  end

  private
  def reference_params
    params.require(:reference).permit(:title, :authors, :medium, :year, :place, :notes)
  end
end
