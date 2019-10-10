class Comment < ApplicationRecord
    belongs_to :movie
    belongs_to :user
    
    validates :comment, presence: true
    validates :movie_id, uniqueness: { scope: :user_id,
        message: "can be commented only once" }
end
