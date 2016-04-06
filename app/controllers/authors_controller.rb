class AuthorsController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @authors = Author.all

    add_breadcrumb Author.model_name.human(count: 2), :authors_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @author = Author.find_by id: params[:id]
    respond_to :js
  end

  def new
    @author = Author.new
    respond_to :js
  end

  def edit
    @author = Author.find_by id: params[:id]
    edit_subaction 'authors/edit', 'authors/form/refresh'
  end

  def create
    @author = Author.create!(author_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Author.model_name.human(count: 1), id: @author.id)
    redirect_to authors_path
  end

  def update
    @author = Author.find_by id: params[:id]
    @author.update!(author_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Author.model_name.human(count: 1), id: @author.id)
    redirect_to authors_path
  end

  def destroy
    destroy_entity_of Author, params
    redirect_to authors_path
  end

  private
  def author_params
    params.require(:author).permit(:name, :notes)
  end
end
