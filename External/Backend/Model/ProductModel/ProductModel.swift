import Foundation 
import ObjectMapper 

class ProductModel: Mappable {

	var id: Int?
	var title: String? 
	var price: Double?
	var description: String? 
	var category: String? 
	var image: String? 
	var rating: Rating? 

	required init?(map: Map){ 
	} 

	func mapping(map: Map) {
		id <- map["id"] 
		title <- map["title"] 
		price <- map["price"] 
		description <- map["description"] 
		category <- map["category"] 
		image <- map["image"] 
		rating <- map["rating"] 
	}
} 

class Rating: Mappable { 

	var rate: Double?
	var count: Int?

	required init?(map: Map){ 
	} 

	func mapping(map: Map) {
		rate <- map["rate"] 
		count <- map["count"] 
	}
} 

