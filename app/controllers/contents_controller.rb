class ContentsController < ApplicationController
  include Common
  include AssociationUpdate

  after_filter { flash.discard if request.xhr? }

  def index
    @contents = Content.all

    add_breadcrumb Content.model_name.human(count: 2), :contents_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @content = Content.find_by id: params[:id]
    respond_to :js
  end

  def new
    @content = Content.new
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
    end
    respond_to :js
  end

  def edit
    @content = Content.find_by id: params[:id]
    edit_subaction 'contents/edit', 'contents/form/refresh'
  end

  def create
    @content = Content.create!(content_params)
    flash[:success] = "Created new content with ID #{@content.id}."
    redirect_to contents_path
  end

  def update
    @content = Content.find_by id: params[:id]
    if params.has_key? :sub_action
      if params.has_key? :content_translation_id
        @content_translation = ContentTranslation.find_by id: params[:content_translation_id]
        update_association_for @content, 'translations', @content_translation,
                               params[:sub_action].to_sym
        respond_to do |format|
          format.js { redirect_to edit_content_path(@content, sub_action: :refresh_nested),
                                  status: :see_other }
        end
      end
    else
      puts content_params.inspect
      @content.update!(content_params)
      flash[:success] = "Updated content with ID #{@content.id}."
      redirect_to contents_path
    end
  end

  def destroy
    destroy_entity_of Content, params
    redirect_to contents_path
  end

  def query_nested_collections
    {
        content_translations: ContentTranslation.where.not(content: @content)
    }
  end

  private
  def content_params
    # TODO move this into validators of Content and ContentTranslation
    if params.has_key? :content and params[:content].has_key? :language
      params[:content][:language] = params[:content][:language].dehumanize

      if params[:content].has_key? :translations_attributes
        params[:content][:translations_attributes].each do |id,vals|
          if vals.has_key? :language
            vals[:language] = vals[:language].dehumanize
          end
        end
      end
    end

    params.require(:content).permit(
        :content,
        :language,
        :deed_id,
        translations_attributes: [:id, :language, :translation]
    )
  end
end
