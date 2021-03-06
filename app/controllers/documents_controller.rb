class DocumentsController < ApplicationController
  include Common
  include AssociationUpdate
  include CollectionAssociation

  after_filter { flash.discard if request.xhr? }

  def index
    if params.has_key? :collection_id
      index_for_nested_collection params[:collection_id]
      @documents = @collection.documents
    elsif params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
      @documents = @deed.documents
      add_breadcrumb Deed.model_name.human(count: 2), deeds_path
      add_breadcrumb @deed.title, deed_path(@deed)
    else
      @documents = Document.all
    end

    add_breadcrumb Document.model_name.human(count: 2), documents_path

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end

  def show
    @document = Document.find_by id: params[:id]
    respond_to :js
  end

  def new
    @document = Document.new
    if params.has_key? :deed_id
      @deed = Deed.find_by id: params[:deed_id]
    end
    respond_to :js
  end

  def edit
    @document = Document.find_by id: params[:id]
    edit_subaction 'documents/edit', 'documents/form/refresh'
  end

  def create
    @document = Document.create!(document_params)
    flash[:success] = t('views.flash.created_entity',
                        what: Document.model_name.human, id: @document.id)
    redirect_to documents_path
  end

  def update
    @document = Document.find_by id: params[:id]
    if params.has_key? :sub_action
      update_associated_collection_for @document,
                                       edit_document_path(@document, sub_action: :refresh_nested)
    else
      @document.update!(document_params)
      flash[:success] = t('views.flash.updated_entity',
                          what: Document.model_name.human, id: @document.id)
      redirect_to documents_path
    end
  end

  def destroy
    destroy_entity_of Document, params
    redirect_to documents_path
  end

  def query_nested_collections
    {
        collections: Collection.where('id NOT IN (?)',
                                      CollectionDocument.select(:collection_id)
                                          .where(document_id: @document.id))
    }
  end

  private
  def document_params
    params.require(:document).permit(:title, :document_type, :notes, :deed_id)
  end
end
