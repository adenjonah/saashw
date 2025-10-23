class Movie < ActiveRecord::Base
  def self.with_same_director(movie)
    where(director: movie.director)
  end

  def others_by_same_director
    Movie.with_same_director(self).where.not(id: self.id)
  end
end
