class SourcesController < ApplicationController
  after_filter { flash.discard if request.xhr? }

  def index
    @sources = Source.all
  end

  def show
    @source = Source.find params[:id]
    respond_to :js
  end

  def new
    @source = Source.new
    respond_to :js
  end

  def edit
    @source = Source.find params[:id]
    respond_to :js
  end

  def create
    @source = Source.create!(source_params)
    flash[:success] = "Created new source with ID #{@source.id}"
    redirect_to sources_path
  end

  def update
    @source = Source.find params[:id]
    @source.update!(source_params)
    flash[:success] = "Updated source with ID #{@source.id}."
    redirect_to sources_path
  end

  def destroy
    @source = Source.find params[:id]
    @source.delete
    flash[:success] = "Deleted source with ID #{@source.id}."
    redirect_to sources_path
  end

  private
  def source_params
    params.require(:source).permit(:title, :notes, :source_type)
  end
end
