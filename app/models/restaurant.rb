class Restaurant < ActiveRecord::Base
	
  belongs_to :user
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

  def belongs_to_current_user
    current_user.restaurants.include? self
  end
end
