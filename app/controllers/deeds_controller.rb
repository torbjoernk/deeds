class DeedsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :reference_id
      @reference = Reference.find_by id: params[:reference_id]
      add_breadcrumb Reference.model_name.human(count: 1)
      add_breadcrumb @reference.title
      @deeds = @reference.deeds
    else
      @deeds = Deed.all
    end

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
          @content = Content.find_by!(id: params[:content_id])
          @content.delete
          flash[:success] = t('views.flash.updated_entity',
                              what: Deed.model_name.human(count: 1), id: @deed.id)
          target = 'deeds/form/refresh'

        when :deassoc_seal
          @seal = Seal.find_by!(id: params[:seal_id])
          @seal.delete
          flash[:success] = t('views.flash.updated_entity',
                              what: Deed.model_name.human(count: 1), id: @deed.id)
          target = 'deeds/form/refresh'

        when :remove_mention_entry
          @mention_entry = MentionEntry.find_by id: params[:mention_entry_id]
          @deed.mention_entries.delete @mention_entry
          @deed.save!
          @mention_entry.delete
          flash[:success] = t('views.deed.flash.removed_mention_entry')
          target = 'deeds/show'

        when :remove_reference
          @reference = Reference.find_by id: params[:reference_id]
          @deed.references.delete @reference
          @deed.save!
          flash[:success] = t('views.deed.flash.removed_reference')
          target = 'deeds/show'
        else
          raise StandardError.new "Wrong sub_action key: #{params[:sub_action]}"
      end
      @unassociated = query_nested_collections
      respond_to do |format|
        format.js   { render partial: target }
        format.html { redirect_to deed_path(@deed) }
      end
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
