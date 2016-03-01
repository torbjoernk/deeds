module Common
  protected
  def destroy_entity_of(klass, params)
    entity = klass.find params[:id]
    entity.delete
    flash[:success] = "Deleted #{klass.model_name.human} with ID #{entity.id}."
  end
end
