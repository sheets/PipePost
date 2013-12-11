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
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def blog
    @title="blog"
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def contact
    @title="contact us"
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def shop
    @title="shop"
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def cart
    @title="cart"
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end

  def pricing_table
    @title="pricing table"
    @description="Lorem ipsum dolor sit amet"
    respond_to do |format|
      format.json
      format.html
    end
  end
end
