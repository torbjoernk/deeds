module Common
  def edit_subaction(form_view, nested_view)
    if params.has_key? :sub_action
      if params[:sub_action].to_sym == :refresh_nested
        @unassociated = query_nested_collections
      end
      respond_to do |format|
        format.js { render partial: nested_view }
      end
    else
      respond_to do |format|
        format.js { render form_view }
      end
    end
  end

  def destroy_entity_of(klass, params)
    entity = klass.find params[:id]
    entity.delete
    flash[:success] = "Deleted #{klass.model_name.human} with ID #{entity.id}."
  end

  def query_nested_collections
  end
end
