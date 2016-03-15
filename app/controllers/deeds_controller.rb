class DeedsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @deeds = Deed.all

    add_breadcrumb Deed.model_name.plural.humanize, :deeds_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @deed = Deed.find params[:id]
    respond_to do |format|
      format.html {
        add_breadcrumb Deed.model_name.plural.humanize, :deeds_path
        add_breadcrumb @deed.title, deed_path(@deed)
        render 'deeds/show'
      }
      format.js   { render 'deeds/show' }
    end
  end

  def new
    @deed = Deed.new
    respond_to do |format|
      format.js { render 'deeds/new' }
    end
  end

  def edit
    @deed = Deed.find params[:id]
    edit_subaction 'deeds/edit', 'deeds/form/refresh'
  end

  def create
    @deed = Deed.create!(deed_params)
    flash[:success] = "Created new deed with ID #{@deed.id}"
    redirect_to deeds_path
  end

  def update
    @deed = Deed.find params[:id]
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :deassoc_content
        @content = Content.find params[:content_id]
        @deed.update!(content: nil)
        respond_to do |format|
          format.js { render partial: 'deeds/form/refresh' }
        end
      end
    else
      @deed.update!(deed_params)
      flash[:success] = "Updated deed with ID #{@deed.id}."
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
