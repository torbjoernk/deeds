class MentionsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @mentions = Mention.all

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
    @mention.save!
    flash[:success] = t :created_entity, scope: [:views, :person, :flash], id: @mention.id
    redirect_to mentions_path
  end

  def update
    @mention = Mention.find_by id: params[:id]
    @mention.update!(mention_params)
    flash[:success] = t :updated_entity, scope: [:views, :flash], what: Mention.model_name.human, id: @mention.id
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
