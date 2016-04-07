class MentionsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :person_id
      @person = Person.find_by id: params[:person_id]
      add_breadcrumb Person.model_name.human(count: 1), people_path
      add_breadcrumb @person.name
      @mentions = @person.mentions
    elsif params.has_key? :place_id
      @place = Place.find_by id: params[:place_id]
      add_breadcrumb Place.model_name.human(count: 1), places_path
      add_breadcrumb @place.title
      @mentions = @place.mentions
    elsif params.has_key? :role_id
      @role = Role.find_by id: params[:role_id]
      add_breadcrumb Role.model_name.human(count: 1), roles_path
      add_breadcrumb @role.title
      @mentions = @role.mentions
    elsif params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      add_breadcrumb Deed.model_name.human(count: 1), deeds_path
      add_breadcrumb @deed.title, deed_path(@deed)
      @mentions = @deed.mentions
    else
      @mentions = Mention.all
    end

    add_breadcrumb Mention.model_name.human(count: 2), mentions_path

    respond_to do |format|
      format.html { render 'mentions/index' }
      format.js   { render 'mentions/index' }
    end
  end

  def show
    @mention = Mention.find_by id: params[:id]
    respond_to :js
  end

  def new
    @mention = Mention.new
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      @mention.deed = @deed
    end
    if params.has_key? 'sub_action' and params[:sub_action].to_sym == :form_events
      respond_to do |format|
        format.js { render partial: 'mentions/form/form_events' }
      end
    else
      respond_to :js
    end
  end

  def edit
    @mention = Mention.find_by id: params[:id]
    if params.has_key? 'sub_action' and params[:sub_action].to_sym == :form_events
      respond_to do |format|
        format.js { render partial: 'mentions/form/form_events' }
      end
    else
      respond_to :js
    end
  end

  def create
    @mention = Mention.create(mention_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Mention.model_name.human, id: @mention.id)
    redirect_to mentions_path
  end

  def update
    @mention = Mention.find_by id: params[:id]
    @mention.update!(mention_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Mention.model_name.human, id: @mention.id)
    redirect_to mentions_path
  end

  def destroy
    destroy_entity_of Mention, params
    redirect_to mentions_path
  end

  private
  def mention_params
    filtered = params.require(:mention).permit(:id, :deed, :person, :place, :role, :notes)

    if filtered[:deed].to_s.empty?
      filtered[:deed] = nil
    else
      filtered[:deed] = Deed.find_by! title: filtered[:deed].to_s
    end

    if filtered[:person].to_s.empty?
      params['mention']['person'] = nil
    else
      filtered[:person] = Person.find_by! name: filtered[:person].to_s
    end

    if filtered[:place].to_s.empty?
      filtered[:place] = nil
    else
      filtered[:place] = Place.find_by! title: filtered[:place].to_s
    end

    if filtered[:role].to_s.empty?
      filtered[:role] = nil
    else
      filtered[:role] = Role.find_by! title: filtered[:role].to_s
    end

    filtered
  end
end
