module ArchiveAssociation
  include AssociationUpdate

  protected
  def index_for_nested_archive(archive_id)
    @archive = Archive.find archive_id
    add_breadcrumb Archive.model_name.human, archives_path
  end

  protected
  def update_associated_archive_for(target, redirect_path)
    if params.has_key? :archive_id
      @archive = Archive.find(params[:archive_id])
      update_association_for target, 'archives', @archive, params[:sub_action].to_sym
      respond_to do |format|
        format.js { redirect_to redirect_path, status: :see_other }
      end
    end
  end
end
