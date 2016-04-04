class ContentTranslationsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def new
    @content_translation = ContentTranslation.new
    respond_to do |format|
      format.html { render partial: 'contents/content_translations/form',
                           locals: { content_id: params[:content_id] } }
    end
  end

  def show
    @content_translation = ContentTranslation.find_by id: params[:id]
    respond_to do |format|
      format.js { render 'contents/content_translations/show' }
    end
  end

  def edit
    @content_translation = ContentTranslation.find_by id: params[:id]
    edit_subaction 'contents/content_translations/edit',
                   'contents/content_translations/form/refresh'
  end

  def create
    @content_translation = ContentTranslation.create!(content_translation_params)
    flash[:success] = t('views.flash.created_entity',
                        what: ContentTranslation.model_name.human(count: 1),
                        id: @content_translation.id)
    respond_to do |format|
      format.js {
        redirect_to edit_content_path(params[:content_id],
                                      format: :js,
                                      params: { created_translation: @content_translation.id }),
                    status: :see_other
      }
    end
  end

  def update
    @content_translation = ContentTranslation.find_by id: params[:id]
    if params.has_key? :sub_action
    else
      @content_translation.update!(content_translation_params)
      flash[:success] = t('views.flash.updated_entity',
                          what: ContentTranslation.model_name.human(count: 1),
                          id: @content_translation.id)
      respond_to :js
    end
  end

  def destroy
    destroy_entity_of ContentTranslation, params
    respond_to do |format|
      format.js { redirect_to edit_content_path(params[:content_id],
                                                format: :js,
                                                params: { deleted_translation: params[:id] }),
                              status: :see_other }
    end
  end

  private
  def content_translation_params
    if params.has_key? :content_translation and params[:content_translation].has_key? :language
      params[:content_translation][:language] = params[:content_translation][:language].dehumanize
    end

    params.require(:content_translation).permit(:translation, :language, :content_id)
  end
end
