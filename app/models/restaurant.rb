class Restaurant < ActiveRecord::Base
	has_many :reviews,
      -> { extending WithUserAssociationExtension }, dependent: :destroy
	validates :name, length: { minimum: 3 }, uniqueness: true

	# def average_rating
	# 	return 'N/A' if reviews.none?
	# 	# reviews.average(:rating)
	# 	reviews.sum(:rating) / reviews.count
	# end

	def average_rating
    return "N/A" if reviews.none?
    sum = 0
    i = 0
    reviews.each do |review|
      sum += review.rating
      i+=1
    end
    return sum/i.to_f
  end
end
