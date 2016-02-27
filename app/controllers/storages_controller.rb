class StoragesController < ApplicationController
  after_filter { flash.discard if request.xhr? }

  def index
    @storages = Storage.all
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
    respond_to :js
  end

  def update
    @storage = Storage.find params[:id]
    @storage.update!(storage_params)
    flash[:success] = "Updated storage with ID #{@storage.id}."
    redirect_to storages_path
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
