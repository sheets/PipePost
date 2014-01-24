class StaticPagesController < ApplicationController
  layout 'static_pages' 
  def home
    respond_to do |format|
      format.js
      format.html
    end
  end

  def about
    @title="about"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def blog
    @title="blog"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def contact
    @title="contact us"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def cart
    @title="cart"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def subscribe
    @title="Subscribe"
    @breadcrumb=@title
    @description="Lorem ipsum dolor sit amet"
    @plans=Plan.select("name,price")
    respond_to do |format|
      format.json
      format.html
    end
  end
end
