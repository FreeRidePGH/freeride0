class BikeAssesment < ActiveRecord::Base
  validates :bike_id, :presence => true 
  
	def self.conditionTooltip
		ttstring =  "<table><tr><th>Quality</th><th>Description</th><th>Price*</th></tr>"
		ttstring += "<tr><td>A</td><td>Frames of Good Material(chromoly, aluminum). Mid to high end components, even if some are missing.</td><td> $120 or more.</td></tr>"
		ttstring += "<tr><td>B</td><td>Start bikes in a bike shop. The frame accepts 3-piece cranks and has other good features. All of the parts are low-end to mid-range. Older bikes that were high-end of their time.</td><td>$70-119</td></tr>"
		ttstring += "<tr><td>C</td><td>Department store bikes with modern features and no gimmicks. Older bikes that were mid-range of their time</td><td>$40-69</td></tr>" 
		ttstring += "<tr><td>D</td><td>Department store bikes with rear suspension or other gimmicks. Outdated department bikes from the 80s or ealier.</td><td>$39 or less</td></tr>"
		ttstring += "<tr><td>F</td><td>Failure. No reason to keep this bicycle and not expected to be sold in any condition.</td><td>$0</td></tr></table>"
		ttstring += "<br/>*Fully repaired price - price of a bike assuming it has all components and passes safety inspection."
		return ttstring
	end
	
	def self.qualityTooltip
		ttstring =  "<table><tr><th>Condition</th><th>Description</th><th>Component completeness</th></tr>"
		ttstring += "<tr><td>A</td><td>Passes the fix for sale completion checklist and would be ready to sell</td><td>100%</td></tr>"
		ttstring += "<tr><td>B</td><td>The bicycle is complete, and it satisfies at least half of the fix for sale completion checklist.</td><td>100%</td></tr>"
		ttstring += "<tr><td>C</td><td>The bicycle is complete but it meets less than half of the fix for sale completion check list. Or, the bicycle is missing important parts, but what is there is working well.</td><td>75%-100%</td></tr>" 
		ttstring += "<tr><td>D</td><td>The bicycle is missing components. The present components are in need of major repair.</td><td>75%-50%</td></tr>"
		ttstring += "<tr><td>F</td><td>This bike would require significant work to function. Repairing it would be equivalent to starting from a frame if it is not at that point already.</td><td>50% or less</td></tr></table>"
		return ttstring		
	end
	
	def self.priceTooltip
		ttstring = "Sale Price = Base - (Damage) - (Labor) - (Missing Parts Cost)<br/><br/>"
		ttstring += "1. Base: What we would sell it for in mint condition<br/><br/>"
		ttstring += "2. Damage: Subtract $5 to $20 for rust and wear, if there is any<br/><br/>"
		ttstring += "3. Labor: Subtract needed labor = (number of hours of work needed) x ($8 per hour)<br/><br/>"
		ttstring += "4. Missing Parts: Subtract some discount for any stuff it is obvious they will have to buy new(example, 27\" tires or a rear cassette). This does not apply to people who want to do single-speed or fixed gear conversions or other customizations since those customizations are not necessary for getting the bike up and running."
		return ttstring
	end
	
	def self.wheelsizelist
		return ["635", "630", "622", "599", "597", "590", "587", "584", "571", "559", "547", "540", "520", "507", "490", "457", "451", "440", "419", "406", "390", "369", "355", "349", "340", "337", "317", "305", "203", "152", "137"]
	end
end
