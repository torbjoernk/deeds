class MentionsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @mentions = Mention.all

    add_breadcrumb Mention.model_name.plural.humanize, mentions_path

    respond_to do |format|
      format.html { render 'mentions/index' }
      format.js   { render 'mentions/index' }
    end
  end

  def show
    @mention = Mention.find params[:id]
    respond_to :js
  end

  def new
    @mention = Mention.new
    respond_to :js
  end

  def edit
    @mention = Mention.find params[:id]
    edit_subaction 'mentions/edit', 'mentions/form/refresh'
  end

  def create
    @mention = Mention.create!(mention_params)
    flash[:success] = "Created new mention with ID #{@mention.id}"
    redirect_to mentions_path
  end

  def update
    @mention = Mention.find params[:id]
    @mention.update!(mention_params)
    flash[:success] = "Updated mention with ID #{@mention.id}."
    redirect_to mentions_path
  end

  def destroy
    destroy_entity_of Mention, params
    redirect_to mentions_path
  end

  private
  def mention_params
    params.require(:mention).permit(:deed_id, :person_id, :place_id, :role_id, :notes)
  end
end
