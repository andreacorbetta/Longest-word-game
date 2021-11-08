require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    char = params[:word].upcase.chars.all? { |letter| params[:word].count(letter) <= params[:letters].split.count(letter) }
    if json['found'] && !char || !char
      @result = "#{params[:word]} cannot be made with the current grid"
    elsif !json['found'] && char || !json['found']
      @result = "#{params[:word]} is not an English word"
    else
      @result = "#{params[:word]} is a valid word"
    end
  end
end
