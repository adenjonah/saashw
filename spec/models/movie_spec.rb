require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#with_same_director' do
    it 'returns movies with the same director' do
      movie1 = Movie.create(title: 'Movie 1', director: 'Director A', rating: 'PG', release_date: '2020-01-01')
      movie2 = Movie.create(title: 'Movie 2', director: 'Director A', rating: 'PG', release_date: '2020-01-02')
      movie3 = Movie.create(title: 'Movie 3', director: 'Director B', rating: 'PG', release_date: '2020-01-03')

      result = Movie.with_same_director(movie1)
      expect(result).to include(movie1, movie2)
      expect(result).not_to include(movie3)
    end
  end

  describe '#others_by_same_director' do
    it 'returns other movies by the same director, excluding self' do
      movie1 = Movie.create(title: 'Movie 1', director: 'Director A', rating: 'PG', release_date: '2020-01-01')
      movie2 = Movie.create(title: 'Movie 2', director: 'Director A', rating: 'PG', release_date: '2020-01-02')
      movie3 = Movie.create(title: 'Movie 3', director: 'Director B', rating: 'PG', release_date: '2020-01-03')

      result = movie1.others_by_same_director
      expect(result).to include(movie2)
      expect(result).not_to include(movie1, movie3)
    end
  end
end
