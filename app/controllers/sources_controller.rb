class SourcesController < ApplicationController
  include AssociationUpdate

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :archive_id
      @archive = Archive.find(params[:archive_id])
      add_breadcrumb Archive.model_name.human, archives_path
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
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :refresh_nested
        @free_archives = Archive.where('id NOT IN (?)',
                                       ArchiveSource.select(:archive_id).where(source_id: @source))
      end
      respond_to do |format|
        format.js { render partial: 'sources/form/refresh' }
      end
    else
      respond_to do |format|
        format.js { render 'sources/edit' }
      end
    end
  end

  def create
    @source = Source.create!(source_params)
    flash[:success] = "Created new source with ID #{@source.id}"
    redirect_to sources_path
  end

  def update
    @source = Source.find params[:id]
    if params.has_key? :sub_action
      if params.has_key? :archive_id
        @archive = Archive.find(params[:archive_id])
        update_association_for @source, 'archives', @archive, params[:sub_action].to_sym
        respond_to do |format|
          format.js { redirect_to edit_source_path(@source, sub_action: :refresh_nested),
                                  status: :see_other }
        end
      end
    else
      @source.update!(source_params)
      flash[:success] = "Updated source with ID #{@source.id}."
      redirect_to sources_path
    end
  end

  def destroy
    @source = Source.find params[:id]
    @source.delete
    flash[:success] = "Deleted source with ID #{@source.id}."
    redirect_to sources_path
  end

  private
  def source_params
    params.require(:source).permit(:title, :source_type, :notes)
  end
end
