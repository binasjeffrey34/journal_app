class PagesController < ApplicationController
  def home
  end

  def users
  end

  def index
    @pages = Page.all
  end

  def show 
    @pages = Page.find(params[:id])
  end
end
