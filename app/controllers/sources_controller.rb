class SourcesController < ApplicationController
  include Common
  include AssociationUpdate
  include CollectionAssociation

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :collection_id
      index_for_nested_collection params[:collection_id]
      @sources = @collection.sources
    elsif params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      @sources = @deed.sources
      add_breadcrumb Deed.model_name.human, deeds_path
    else
      @sources = Source.all
    end

    add_breadcrumb Source.model_name.plural.humanize, :sources_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @source = Source.find_by id: params[:id]
    respond_to :js
  end

  def new
    @source = Source.new
    respond_to do |format|
      format.js { render 'sources/new' }
    end
  end

  def edit
    @source = Source.find_by id: params[:id]
    edit_subaction 'sources/edit', 'sources/form/refresh'
  end

  def create
    @source = Source.create!(source_params)
    flash[:success] = "Created new source with ID #{@source.id}"
    redirect_to sources_path
  end

  def update
    @source = Source.find_by id: params[:id]
    if params.has_key? :sub_action
      update_associated_collection_for @source,
                                       edit_source_path(@source, sub_action: :refresh_nested)
    else
      @source.update!(source_params)
      flash[:success] = "Updated source with ID #{@source.id}."
      redirect_to sources_path
    end
  end

  def destroy
    destroy_entity_of Source, params
    redirect_to sources_path
  end

  def query_nested_collections
    {
        collections: Collection.where('id NOT IN (?)',
                                      CollectionSource.select(:collection_id).where(source_id: @source))
    }
  end

  private
  def source_params
    params.require(:source).permit(:title, :source_type, :notes)
  end
end
