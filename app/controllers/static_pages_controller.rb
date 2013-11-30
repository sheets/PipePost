class StaticPagesController < ApplicationController
  layout 'static_pages' 
  def home
    respond_to do |format|
      format.js
      format.html
    end
  end

  def about
  end

  def blog
  end

  def contact
  end

  def store
  end
end
