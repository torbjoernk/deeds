class ContentTranslationsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @content_translations = ContentTranslation.all

    add_breadcrumb ContentTranslation.model_name.plural.humanize, :contents_path
  end

  def show
    @content_translation = ContentTranslation.find params[:id]
    respond_to :js
  end

  def new
    @content_translation = ContentTranslation.new
    respond_to :js
  end

  def edit
    @content_translation = ContentTranslation.find params[:id]
    edit_subaction 'content_translations/edit', 'content_translations/form/refresh'
  end

  def create
    @content_translation = ContentTranslation.create!(content_translation_params)
    flash[:success] = "Created new content translation with ID #{@content_translation.id}."
    redirect_to content_translations_path
  end

  def update
    @content_translation = ContentTranslation.find params[:id]
    if params.has_key? :sub_action
    else
      @content_translation.update!(content_translation_params)
      flash[:success] = "Updated content translation with ID #{@content_translation.id}."
      redirect_to content_translations_path
    end
  end

  def destroy
    destroy_entity_of ContentTranslation, params
    redirect_to content_translations_path
  end

  private
  def content_translation_params
    if params.has_key? :content_translation and params[:content_translation].has_key? :language
      params[:content_translation][:language] = params[:content_translation][:language].dehumanize
    end

    params.require(:content_translation).permit(:translation, :language)
  end
end
