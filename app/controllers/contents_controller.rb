class ContentsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @contents = Content.all

    add_breadcrumb Content.model_name.plural.humanize, :contents_path
  end

  def show
    @content = Content.find params[:id]
    respond_to :js
  end

  def new
    @content = Content.new
    respond_to :js
  end

  def edit
    @content = Content.find params[:id]
    edit_subaction 'contents/edit', 'contents/form/refresh'
  end

  def create
    @content = Content.create!(content_params)
    flash[:success] = "Created new content with ID #{@content.id}."
    redirect_to contents_path
  end

  def update
    @content = Content.find params[:id]
    if params.has_key? :sub_action
    else
      @content.update!(content_params)
      flash[:success] = "Updated content with ID #{@content.id}."
      redirect_to contents_path
    end
  end

  def destroy
    destroy_entity_of Content, params
    redirect_to contents_path
  end

  private
  def content_params
    if params.has_key? :content and params[:content].has_key? :language
      params[:content][:language] = params[:content][:language].dehumanize
    end

    params.require(:content).permit(:content, :language)
  end
end
