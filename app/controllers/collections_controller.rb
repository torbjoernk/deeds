class CollectionsController < ApplicationController
  include Common
  include AssociationUpdate

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :storage_id
      @storage = Storage.find_by id: params[:storage_id]
      add_breadcrumb Storage.model_name.human(count: 1), storages_path
      @collections = @storage.collections
    elsif params.has_key? :source_id
      @source = Source.find_by id: params[:source_id]
      add_breadcrumb Source.model_name.human(count: 1), sources_path
      @collections = @source.collections
    else
      @collections = Collection.all
    end

    add_breadcrumb Collection.model_name.human(count: 2), collections_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @collection = Collection.find_by id: params[:id]
    respond_to :js
  end

  def new
    @collection = Collection.new
    respond_to :js
  end

  def edit
    @collection = Collection.find_by id: params[:id]
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :refresh_nested
        @free_sources = Source.where('id NOT IN (?)',
                                     CollectionSource.select(:source_id).where(collection_id: @collection.id))
        @free_storages = Storage.where('id NOT IN (?)',
                                       CollectionStorage.select(:storage_id).where(collection_id: @collection.id))
      end
      respond_to do |format|
        format.js { render partial: 'collections/form/refresh' }
      end
    else
      respond_to do |format|
        format.js { render 'collections/edit' }
      end
    end
  end

  def update
    @collection = Collection.find_by id: params[:id]
    if params.has_key? :sub_action
      if params.has_key? :source_id
        @source = Source.find_by id: params[:source_id]
        update_association_for @collection, 'sources', @source, params[:sub_action].to_sym
      elsif params.has_key? :storage_id
        @storage = Storage.find_by id: params[:storage_id]
        update_association_for @collection, 'storages', @storage, params[:sub_action].to_sym
      end
      respond_to do |format|
        format.js { redirect_to edit_collection_path(@collection, sub_action: :refresh_nested),
                                status: :see_other }
      end
    else
      @collection.update!(collection_params)
      flash[:success] = t(:updated_entity, scope: [:views, :flash],
                          what: Collection.model_name.human(count: 1), id: @collection.id)
      redirect_to collections_path
    end
  end

  def create
    @collection = Collection.create!(collection_params)
    flash[:success] = t(:created_entity, scope: [:views, :collection, :flash], id: @collection.id)
    redirect_to collections_path
  end

  def destroy
    destroy_entity_of Collection, params
    redirect_to collections_path
  end

  private
  def collection_params
    params.require(:collection).permit(:title, :abbr, :notes)
  end
end
