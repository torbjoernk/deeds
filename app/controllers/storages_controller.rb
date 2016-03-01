class StoragesController < ApplicationController
  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :archive_id
      @archive = Archive.find(params[:archive_id])
      add_breadcrumb Archive.model_name.human, archives_path
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
      if params.has_key? :archive_id
        @archive = Archive.find(params[:archive_id])
        if params[:sub_action].to_sym == :deassociate
          @storage.archives.delete(@archive) if @storage.archives.include? @archive
        elsif params[:sub_action].to_sym == :associate
          @storage.archives << @archive
          @storage.save!
        end
        respond_to do |format|
          format.js { redirect_to edit_storage_path(@storage, sub_action: :refresh_nested),
                                  status: :see_other }
        end
      end
    else
      @storage.update!(storage_params)
      flash[:success] = "Updated storage with ID #{@storage.id}."
      redirect_to storages_path
    end
  end

  def destroy
    @storage = Storage.find params[:id]
    @storage.delete
    flash[:success] = "Deleted storage with ID #{@storage.id}."
    redirect_to storages_path
  end

  private
  def storage_params
    params.require(:storage).permit(:title, :notes)
  end
end
