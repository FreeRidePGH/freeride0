class Bike < ActiveRecord::Base
  has_one :eab_project
  belongs_to :brand, :class_name => "BikeBrand"
  belongs_to :model, :class_name => "BikeModel"
  belongs_to :location
  has_many :safety_inspections, :order => "inspection_date DESC, created_at DESC"
  
  has_attached_file :image1, :default_url => "/images/missing.png",
                    :styles => { :large => "1024x768>", :medium => "300x300>", :small => "100x100>", :tiny => "50x50#" }
  has_attached_file :image2, :default_url => "/images/missing.png",
                    :styles => { :large => "1024x768>", :medium => "300x300>", :small => "100x100>", :tiny => "50x50#" }
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
  
  def self.searchStatus(search)
    if search
      where('status LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def has_passed_safety?
    return false if self.safety_inspections.empty?
    self.safety_inspections[0].passed?
  end

  def self.statuslist
	return ["Available", "In Shop", "EAB in Progress", "FFS in Progress", "Youth", "Off-site", "Sold", "Departed-FFS", "Departed-EAB", "Departed-ASIS", "Departed-Scrap", "Departed-Other", "Missing", "Other"]
  end
  
  def self.wheelTooltip
  
	#ttstring = "<table id='wheeltooltip'><tr><td>"
	
	ttstring = "<table><tr><th>ISO</th><th>Traditional</th><th>ISO</th><th>Traditional</th><th>ISO</th><th>Traditional</th></tr>"
   	ttstring += "<tr><td>635 mm</td><td>28 x 1 1/2, 700 B</td><td>520 mm</td><td>24 x 1, 24 x 1 1/8</td><td>340 mm</td><td>400 A</td></tr>"
	ttstring += "<tr><td>630 mm</td><td>27 x anything</td><td>507 mm</td><td>24 x 1.5- x 2.125</td><td>337 mm</td><td>16 x 1 3/8</td></tr>"
	ttstring += "<tr><td>622 mm</td><td>700 C, 28 x (two fractions), 29 inch<br />(28 x 1 1/2 F.13 Canada)</td><td>490 mm</td><td>550 A</td><td>317 mm</td><td>16 x 1 3/4</td></tr>"
	ttstring += "<tr><td>599 mm</td><td>26 x 1.25, x 1.375</td><td>457 mm</td><td>22 x 1.75; x 2.125</td><td>305 mm</td><td>16 x 1.75- x 2.125</td></tr>"
	ttstring += "<tr><td>597 mm</td><td>26 x 1 1/4, 26 x 1 3/8 (S-6)</td><td>451 mm</td><td>20 x 1 1/8; x 1 1/4; x 1 3/8</td><td>203 mm</td><td>12 1/2 X anything.</td></tr>"
	ttstring += "<tr><td>590 mm</td><td>26 x 1 3/8 (E.A.3), 650 A</td><td>440 mm</td><td>500 A</td><td>152 mm</td><td>10 x 2</td></tr>"
	ttstring += "<tr><td>587 mm</td><td>700 D</td><td>419 mm</td><td>20 x 1 3/4</td><td>137 mm</td><td>8 x 1 1/4</td></tr>"
	ttstring += "<tr><td>584 mm</td><td>650B, 26 x 1 1/2</td><td>406 mm</td><td>20 x 1.5- x 2.125</td></tr>"
	ttstring += "<tr><td>571 mm</td><td>26 x 1, 26 x 1 3/4, 650 C</td><td>390 mm</td><td>450 A</td></tr>"
	ttstring += "<tr><td>559 mm</td><td>26 x 1.00- x 2.125</td><td>369 mm</td><td>17 x 1 1/4</td></tr>"
	ttstring += "<tr><td>547 mm</td><td>24 x 1 1/4, 24 x 1 3/8 (S-5)</td><td>355 mm</td><td>18 x 1.5- x 2.125</td></tr>"
	ttstring += "<tr><td>540 mm</td><td>24 x 1 1/8, 24 x 1 3/8 (E.5), 600 A</td><td>349 mm</td><td>16 x 1 3/8</td></tr>"
	ttstring += "</table>"

	
	
	#ttstring += "</td></tr></table>"

	end
  
end
