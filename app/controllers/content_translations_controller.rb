class ContentTranslationsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

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
    respond_to :js
  end

  def update
    @content_translation = ContentTranslation.find params[:id]
    if params.has_key? :sub_action
    else
      @content_translation.update!(content_translation_params)
      flash[:success] = "Updated content translation with ID #{@content_translation.id}."
      respond_to :js
    end
  end

  def destroy
    logger.info params.inspect
    # destroy_entity_of ContentTranslation, params
    respond_to do |format|
      format.js { render partial: 'contents/form/refresh', locals: { deleted_translation_id: params[:id] } }
    end
  end

  private
  def content_translation_params
    if params.has_key? :content_translation and params[:content_translation].has_key? :language
      params[:content_translation][:language] = params[:content_translation][:language].dehumanize
    end

    params.require(:content_translation).permit(:translation, :language)
  end
end
