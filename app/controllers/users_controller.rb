class UsersController < ApplicationController
  before_action :skip_password_attribute, only: :update
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
    # @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @histories = @user.appointment_applicant
    @reviews = @user.reviews.to_a
    @avg_rating = @user.average_rating(@user)
    # @user_categories = Category.find(current_user.user_category.ids)
    # @categories = Category.all
    # @user_categories = current_user.user_category.build
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      # log_in @user
      # flash[:success] = "Welcome to Freelancer apps, #{@user.fullname}!"
      # redirect_to @user

      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

    else
      render 'new'
    end
  end

  def update
    params[:user][:category_ids] ||= []
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    # params.require(:user).permit(:fullname, :username, :email,
    #                              :password, :password_confirmation)
    params.require(:user).permit!
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except(:password, :password_validation)
    end
  end

end
