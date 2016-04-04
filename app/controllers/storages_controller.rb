class StoragesController < ApplicationController
  include Common
  include AssociationUpdate
  include CollectionAssociation

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :collection_id
      index_for_nested_collection params[:collection_id]
      @storages = @collection.storages
    else
      @storages = Storage.all
    end

    add_breadcrumb Storage.model_name.human(count: 2), storages_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def new
    @storage = Storage.new
    respond_to :js
  end

  def show
    @storage = Storage.find_by id: params[:id]
    respond_to :js
  end

  def create
    @storage = Storage.create!(storage_params)
    flash[:success] = t :created_entity, scope: [:views, :storage, :flash], id: @storage.id
    redirect_to storages_path
  end

  def edit
    @storage = Storage.find_by id: params[:id]
    edit_subaction 'storages/edit', 'storages/form/refresh'
  end

  def update
    @storage = Storage.find_by id: params[:id]
    if params.has_key? :sub_action
      update_associated_collection_for @storage,
                                       edit_storage_path(@storage, sub_action: :refresh_nested)
    else
      @storage.update!(storage_params)
      flash[:success] = t :updated_entity, scope: [:views, :flash], what: Storage.model_name.human, id: @storage.id
      redirect_to storages_path
    end
  end

  def destroy
    destroy_entity_of Storage, params
    redirect_to storages_path
  end

  def query_nested_collections
    {
        collections: Collection.where('id NOT IN (?)',
                                      CollectionStorage.select(:collection_id).where(storage_id: @storage))
    }
  end

  private
  def storage_params
    params.require(:storage).permit(:title, :notes)
  end
end
