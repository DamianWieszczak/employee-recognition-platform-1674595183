module Admins
  class CategoriesController < AdminsController
    def index
      render :index, locals: { categories: Category.all }
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def create
      category = Category.new(category_params)
      if category.save
        flash[:notice] = 'Category was successfully created'
        redirect_to admins_categories_path
      else
        flash[:alert] = 'Creating category failed'
        render :new, locals: { category: }
      end
    end

    def edit
      render :edit, locals: { category: Category.find(params[:id]) }
    end

    def update
      category = Category.find(params[:id])
      if category.update(category_params)
        flash[:notice] = 'Category was updated'
        redirect_to admins_categories_path
      else
        flash[:alert] = 'Updating Category failed'
        render :edit, locals: { category: }
      end
    end

    def destroy
      @category = Category.find(params[:id])
      if @category.rewards.empty?
        @category.destroy
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
