module Admins
  class CategoriesController < AdminsController
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:notice] = 'Category was successfully created'
        redirect_to admins_categories_path
      else
        flash[:alert] = 'Creating Company Value failed'
        render 'admins/categories/new'
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        flash[:notice] = 'Category was updated'
        redirect_to admins_categories_path
      else
        flash[:alert] = 'Updating Category failed'
        render 'admins/categories/edit'
      end
    end

    def destroy
      @category = Category.find(params[:id])
      if @category.destroy        
        flash[:notice] = 'Category was successfully deleted'
      else
        flash[:alert] = 'Deleting Category failed'
      end
      redirect_to admins_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
