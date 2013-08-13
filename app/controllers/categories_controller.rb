class CategoriesController < ApplicationController
  before_action :require_user
  def index
    if logged_in?
      @categories = Category.all
    else
      redirect_to root_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

end
