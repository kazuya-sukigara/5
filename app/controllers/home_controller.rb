class HomeController < ApplicationController
  def top
  	@books = Book.all

  end

  def about
  end
end
