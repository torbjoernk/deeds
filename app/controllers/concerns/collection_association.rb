module CollectionAssociation
  include AssociationUpdate

  protected
  def index_for_nested_collection(collection_id)
    @collection = Collection.find_by id: collection_id
    add_breadcrumb Collection.model_name.human, collections_path
  end

  protected
  def update_associated_collection_for(target, redirect_path)
    if params.has_key? :collection_id
      @collection = Collection.find_by id: params[:collection_id]
      update_association_for target, 'collections', @collection, params[:sub_action].to_sym
      respond_to do |format|
        format.js { redirect_to redirect_path, status: :see_other }
      end
    end
  end
end
