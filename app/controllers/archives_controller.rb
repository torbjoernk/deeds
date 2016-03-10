class ArchivesController < ApplicationController
  include Common
  include AssociationUpdate

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :storage_id
      @storage = Storage.find(params[:storage_id])
      add_breadcrumb Storage.model_name.human, storages_path
      @archives = @storage.archives
    elsif params.has_key? :source_id
      @source = Source.find(params[:source_id])
      add_breadcrumb Source.model_name.human, sources_path
      @archives = @source.archives
    else
      @archives = Archive.all
    end

    add_breadcrumb Archive.model_name.plural.humanize, archives_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @archive = Archive.find params[:id]
    respond_to :js
  end

  def new
    @archive = Archive.new
    respond_to :js
  end

  def edit
    @archive = Archive.find params[:id]
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :refresh_nested
        @free_sources = Source.where('id NOT IN (?)',
                                     ArchiveSource.select(:source_id).where(archive_id: @archive))
        @free_storages = Storage.where('id NOT IN (?)',
                                       ArchiveStorage.select(:storage_id).where(archive_id: @archive))
      end
      respond_to do |format|
        format.js { render partial: 'archives/form/refresh' }
      end
    else
      respond_to do |format|
        format.js { render 'archives/edit' }
      end
    end
  end

  def update
    @archive = Archive.find params[:id]
    if params.has_key? :sub_action
      if params.has_key? :source_id
        @source = Source.find(params[:source_id])
        update_association_for @archive, 'sources', @source, params[:sub_action].to_sym
      elsif params.has_key? :storage_id
        @storage = Storage.find(params[:storage_id])
        update_association_for @archive, 'storages', @storage, params[:sub_action].to_sym
      end
      respond_to do |format|
        format.js { redirect_to edit_archive_path(@archive, sub_action: :refresh_nested),
                                status: :see_other }
      end
    else
      @archive.update!(archive_params)
      flash[:success] = "Updated archive with ID #{@archive.id}."
      redirect_to archives_path
    end
  end

  def create
    @archive = Archive.create!(archive_params)
    flash[:success] = "Created new archive with ID #{@archive.id}."
    redirect_to archives_path
  end

  def destroy
    destroy_entity_of Archive, params
    redirect_to archives_path
  end

  private
  def archive_params
    params.require(:archive).permit(:title, :notes)
  end
end
