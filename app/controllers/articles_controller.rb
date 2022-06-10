class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def show
    # byebug
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article with id=#{@article.id} was created successfully!"
      # redirect_to article_path(@article)
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article with id=#{@article.id} was updated successfully!"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article with id=#{@article.id} was deleted successfully!"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles!"
      redirect_to @article
    end
  end

  # from scaffolding:
  # before_action :set_article, only: %i[ show edit update destroy ]
  #
  # # POST /articles or /articles.json
  # def create
  #   @article = Article.new(article_params)
  #
  #   respond_to do |format|
  #     if @article.save
  #       format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
  #       format.json { render :show, status: :created, location: @article }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @article.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /articles/1 or /articles/1.json
  # def update
  #   respond_to do |format|
  #     if @article.update(article_params)
  #       format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
  #       format.json { render :show, status: :ok, location: @article }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @article.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /articles/1 or /articles/1.json
  # def destroy
  #   @article.destroy
  #
  #   respond_to do |format|
  #     format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end
end
