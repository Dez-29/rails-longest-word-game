require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  
  def included?
    @letters = params[:letters]
    lettres = params[:word].upcase.split("")
    lettres.all? { |lettre| lettres.count(lettre) <= @letters.count(lettre)}
  end

  def score
    if included?()
      if english_word?(params[:word])
        @result = "Congratulations!"
      else
        @result = "It's not an English word"
      end
    else 
      @result = "It's not in the grid"
    end
    return @result
  end
end
