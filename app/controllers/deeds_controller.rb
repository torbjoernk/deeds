class DeedsController < ApplicationController
  after_filter { flash.discard if request.xhr? }

  def index
    @deeds = Deed.all

    respond_to do |format|
      format.js   { render 'index' }
      format.html { render 'index' }
    end
  end
end
