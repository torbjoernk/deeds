module AssociationUpdate
  protected
  def update_association_for(target, collection, child, action)
    if action == :associate
      target.send(collection) << child
      target.save!
    elsif action == :deassociate
      target.send(collection).delete(child) if target.send(collection).include? child
    end
  end
end
