class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:show, :index]

  def index
    if signed_in?
      @posts = Article.paginate(page: params[:page]).all
    else
      @posts = Article.visible.paginate(page: params[:page]).all
    end
  end

  def show
  end

  def new
    @post = Article.new
  end

  def edit
  end

  def create
    @post = Article.new(article_params)

    if @post.save
      redirect_to @post.path, notice: "Article was successfully created."
    else
      render :new
    end
  end

  def update
    if @post.update(article_params)
      redirect_to @post.path, notice: "Article was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to articles_url, notice: "Article was successfully destroyed."
  end

  private

  def set_article
    @post = Article.where(slug: params[:slug]).first
    return redirect_to(root_path) if @post.private? && !signed_in?
  end

  def article_params
    params.require(:article).permit(:title,
      :subtitle,
      :content,
      :slug,
      :in_reply_to,
      :tags,
      :published_at,
      :private)
  end
end
