class ProductsController < ApplicationController
	layout 'static_pages' 
	def index
    @title="shop"
    @breadcrumb="shop"
    @description="Lorem ipsum dolor sit amet"
    @products=Product.product_type_not_null
    respond_to do |format|
      format.json
      format.html
    end
  end
  def show
  	@product=Product.find(params[:id])
    @title=@product.name
    @description=@product.description
    @breadcrumb="<a href='/shop'> Shop </a>/ #{@product.name}"
    respond_to do |format|
      format.json
      format.html
    end
  end
end
