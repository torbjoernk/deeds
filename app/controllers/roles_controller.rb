class RolesController < ApplicationController
  include Common

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      add_breadcrumb Deed.model_name.human(count: 1), deeds_path
      add_breadcrumb @deed.title, deed_path(@deed)
      @roles = @deed.roles
    else
      @roles = Role.all
    end

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
    flash[:success] = t('views.flash.created_entity',
                        what: Role.model_name.human(count: 1), id: @role.id)
    redirect_to roles_path
  end

  def update
    @role = Role.find_by id: params[:id]
    @role.update!(role_params)
    flash[:success] = t('views.flash.updated_entity',
                        what: Role.model_name.human(count: 1), id: @role.id)
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
