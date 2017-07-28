class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [:create, :destroy]
  before_action :find_like, only: [ :destroy]


  def create
    like = Like.new user: current_user, review: @review
    if cannot? :like, @review
      redirect_to @review, alert: 'You Can Like Your Own Question 💀 !!!! '
    elsif like.save
      redirect_to @review, notice: 'Thanks for liking'
    else
      redirect_to @review, alert: like.errors.full_messages.join(',')
    end
  end

  def destroy
    if @like.destroy
      redirect_to @like.review, notice: '🙃'
    else
      redirect_to @like.review, alert: @like.errors.full_messages.join(', ')
    end
  end


  private
  def find_review
    @review = Review.find(params[:review_id])
  end


  def find_like
    @like = Like.find(params[:id])
  end




end
