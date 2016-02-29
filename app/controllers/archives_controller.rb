class ArchivesController < ApplicationController
  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :storage_id
      @storage = Storage.find(params[:storage_id])
      @archives = @storage.archives
    elsif params.has_key? :source_id
      @source = Source.find(params[:source_id])
      @archives = @source.archives
    else
      @archives = Archive.all
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
    respond_to :js
  end

  def update
    @archive = Archive.find params[:id]
    @archive.update!(archive_params)
    flash[:success] = "Updated archive with ID #{@archive.id}."
    redirect_to archives_path
  end

  def create
    @archive = Archive.create!(archive_params)
    flash[:success] = "Created new archive with ID #{@archive.id}."
    redirect_to archives_path
  end

  def destroy
    @archive = Archive.find params[:id]
    @archive.delete
    flash[:success] = "Deleted archive with ID #{@archive.id}."
    redirect_to archives_path
  end

  private
  def archive_params
    params.require(:archive).permit(:title, :notes)
  end
end
