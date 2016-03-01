class StoragesController < ApplicationController
  include Common
  include AssociationUpdate
  include ArchiveAssociation

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :archive_id
      index_for_nested_archive params[:archive_id]
      @storages = @archive.storages
    else
      @storages = Storage.all
    end

    add_breadcrumb Storage.model_name.plural.humanize, :storages_path
  end

  def new
    @storage = Storage.new
    respond_to :js
  end

  def show
    @storage = Storage.find params[:id]
    respond_to :js
  end

  def create
    @storage = Storage.create!(storage_params)
    flash[:success] = "Created new storage with ID #{@storage.id}."
    redirect_to storages_path
  end

  def edit
    @storage = Storage.find params[:id]
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :refresh_nested
        @free_archives = Archive.where('id NOT IN (?)',
                                       ArchiveStorage.select(:archive_id).where(storage_id: @storage))
      end
      respond_to do |format|
        format.js { render partial: 'storages/form/refresh' }
      end
    else
      respond_to do |format|
        format.js { render 'storages/edit' }
      end
    end
  end

  def update
    @storage = Storage.find params[:id]
    if params.has_key? :sub_action
      update_associated_archive_for @storage, params,
                                    edit_storage_path(@storage, sub_action: :refresh_nested)
    else
      @storage.update!(storage_params)
      flash[:success] = "Updated storage with ID #{@storage.id}."
      redirect_to storages_path
    end
  end

  def destroy
    destroy_entity_of Storage, params
    redirect_to storages_path
  end

  private
  def storage_params
    params.require(:storage).permit(:title, :notes)
  end
end
