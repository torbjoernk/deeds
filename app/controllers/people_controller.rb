class PeopleController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @people = Person.all

    add_breadcrumb Person.model_name.human(count: 2), people_path

    respond_to do |format|
      format.html { render 'people/index' }
      format.js   { render 'people/index' }
    end
  end

  def show
    @person = Person.find_by id: params[:id]
    respond_to :js
  end

  def new
    @person = Person.new
    respond_to :js
  end

  def edit
    @person = Person.find_by id: params[:id]
    edit_subaction 'people/edit', 'people/form/refresh'
  end

  def create
    @person = Person.create!(person_params)
    flash[:success] = t :created_entity, scope: [:views, :person, :flash], id: @person.id
    redirect_to people_path
  end

  def update
    @person = Person.find_by id: params[:id]
    @person.update!(person_params)
    flash[:success] = t :updated_entity, scope: [:views, :flash], what: Person.model_name.human, id: @person.id
    redirect_to people_path
  end

  def destroy
    destroy_entity_of Person, params
    redirect_to people_path
  end

  private
  def person_params
    params.require(:person).permit(:name, :gender, :notes)
  end
end
