class SourcesController < ApplicationController
  include Common
  include AssociationUpdate
  include ArchiveAssociation

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :archive_id
      index_for_nested_archive params[:archive_id]
      @sources = @archive.sources
    else
      @sources = Source.all
    end

    add_breadcrumb Source.model_name.plural.humanize, :sources_path
  end

  def show
    @source = Source.find params[:id]
    respond_to :js
  end

  def new
    @source = Source.new
    respond_to do |format|
      format.js { render 'sources/new' }
    end
  end

  def edit
    @source = Source.find params[:id]
    edit_subaction 'sources/edit', 'sources/form/refresh'
  end

  def create
    @source = Source.create!(source_params)
    flash[:success] = "Created new source with ID #{@source.id}"
    redirect_to sources_path
  end

  def update
    @source = Source.find params[:id]
    if params.has_key? :sub_action
      update_associated_archive_for @source,
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
        archives: Archive.where('id NOT IN (?)',
                                ArchiveSource.select(:archive_id).where(source_id: @source))
    }
  end

  private
  def source_params
    params.require(:source).permit(:title, :source_type, :notes)
  end
end
