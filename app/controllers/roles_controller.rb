class RolesController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    @roles = Role.all

    add_breadcrumb Role.model_name.human(count: 2), roles_path

    respond_to do |format|
      format.html { render 'roles/index' }
      format.js   { render 'roles/index' }
    end
  end

  def show
    @role = Role.find_by id: params[:id]
    respond_to :js
  end

  def new
    @role = Role.new
    respond_to :js
  end

  def edit
    @role = Role.find_by id: params[:id]
    edit_subaction 'roles/edit', 'roles/form/refresh'
  end

  def create
    @role = Role.create!(role_params)
    flash[:success] = t :created_entity, scope: [:views, :role, :flash], id: @role.id
    redirect_to roles_path
  end

  def update
    @role = Role.find_by id: params[:id]
    @role.update!(role_params)
    flash[:success] = t :updated_entity, scope: [:views, :flash], what: Role.model_name.human, id: @role.id
    redirect_to roles_path
  end

  def destroy
    destroy_entity_of Role, params
    redirect_to roles_path
  end

  private
  def role_params
    params.require(:role).permit(:title, :referring, :notes)
  end
end
