class Product < ActiveRecord::Base
	mount_uploader :image, ImageUploader
  attr_accessible :description, :image, :name, :image_cache, :remove_image,:price, :product_type
  scope :product_type_not_null, where('product_type !=(?)','')
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
  	new_record? || slug.blank?
	end
end