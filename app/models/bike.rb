class Bike < ActiveRecord::Base
  has_one :eab_project
  has_one :bike_brand
  has_one :bike_model
  has_one :location
  has_many :safety_inspections, :order => "inspection_date DESC, created_at DESC"
  
  has_attached_file :image1, :default_url => "/images/missing.png",
                    :styles => { :large => "1024x768>", :medium => "300x300>", :small => "100x100>", :tiny => "50x50>" }
  has_attached_file :image2, :default_url => "/images/missing.png",
                    :styles => { :large => "1024x768>", :medium => "300x300>", :small => "100x100>", :tiny => "50x50>" }
  # Paperclip gem validations
  validates_attachment_content_type :image1, 
                                    :content_type => ["image/jpeg", "image/png", "image/gif"],
                                    :message => "Image must be in a JPG, PNG, or GIF format."
  validates_attachment_size :image1, :less_than => 1.megabyte
  validates_attachment_content_type :image2, 
                                    :content_type => ["image/jpeg", "image/png", "image/gif"],
                                    :message => "Image must be in a JPG, PNG, or GIF format."
  validates_attachment_size :image2, :less_than => 1.megabyte
  
  
  attr_accessible :model_id, :brand_id, :location_id, :wheel_size, :frame_size, 
                  :top_tube, :seat_tube, :color, :status, :date_in, :date_out, :bike_id,
                  :image1, :image2
  
  validates_presence_of :bike_id, :message => "ID cannot be blank"
  validates_numericality_of :bike_id, :message =>"ID is invalid"
  validates :brand_id, :presence => true 
  validates_numericality_of :brand_id,  :message => "has to be selected"
  validates_numericality_of :model_id, :message => "is invalid"
  validates_uniqueness_of :bike_id, :message => "ID has already been taken"
  
  def self.search(search)
    if search
      where('bike_id LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def has_passed_safety?
    return false if self.safety_inspections.empty?
    self.safety_inspections[0].passed?
  end

end
