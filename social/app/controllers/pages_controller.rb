class PagesController < ApplicationController
  
  def older
    if session[:page]
      session[:page] += 1
    else
      session[:page] = 1
    end 
  end
  
  def newer
    session[:page] -= 1
  end
end
