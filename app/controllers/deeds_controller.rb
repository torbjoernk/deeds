class DeedsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @deeds = Deed.all

    add_breadcrumb Deed.model_name.human(count: 2), :deeds_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @deed = Deed.find_by id: params[:id]
    respond_to do |format|
      format.html {
        add_breadcrumb Deed.model_name.human(count: 2), :deeds_path
        add_breadcrumb @deed.title, deed_path(@deed)
        render 'deeds/show'
      }
      format.js { render 'deeds/show' }
    end
  end

  def new
    @deed = Deed.new
    respond_to do |format|
      format.js { render 'deeds/new' }
    end
  end

  def edit
    @deed = Deed.find_by id: params[:id]
    edit_subaction 'deeds/edit', 'deeds/form/refresh'
  end

  def create
    @deed = Deed.create!(deed_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Deed.model_name.human(count: 1), id: @deed.id)
    redirect_to deeds_path
  end

  def update
    @deed = Deed.find_by id: params[:id]
    if params.has_key? :sub_action
      case params[:sub_action].to_sym
        when :deassoc_content
          @content = Content.find_by id: params[:content_id]
          @deed.update!(content: nil)
          flash[:success] = t('views.flash.updated_entity',
                              what: Deed.model_name.human(count: 1), id: @deed.id)
        when :remove_mention
          @mention = Mention.find_by id: params[:mention_id]
          @deed.mentions.delete @mention
          @deed.save!
          @mention.delete
          flash[:success] = t('views.deed.flash.removed_mention')
        else
          raise StandardError.new "Wrong sub_action key: #{params[:sub_action]}"
      end
      redirect_to deed_path(@deed), format: 'html'
    else
      @deed.update!(deed_params)
      flash[:success] = t('views.flash.updated_entity',
                          what: Deed.model_name.human(count: 1), id: @deed.id)
      redirect_to deeds_path
    end
  end

  def destroy
    destroy_entity_of Deed, params
    redirect_to deeds_path
  end

  private
  def deed_params
    params.require(:deed).permit(:title, :year, :month, :day, :description, :notes)
  end
end
