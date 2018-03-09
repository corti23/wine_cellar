class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :destroy]

  before_action :all_users,       only: [:index, :create, :update, :destroy]
  before_action :set_user,        only: [:edit, :update, :destroy]
  before_action :set_breadcrumb,  only: [:index, :new, :edit, :show]

  respond_to :html, :js

  def index
    #@users = User.paginate(page: params[:page])
    respond_to do |format|
      format.html 
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def show
    @user = User.find(params[:id])
    @bottles = @user.bottles.paginate(page: params[:page])

    add_breadcrumb @user.name, user_path(@user)
  end

  def new
    @user = User.new
    add_breadcrumb t(:adduser), signup_path
  end

  def create

    if user_params[:email].downcase =~/^.+@gmail\.com/
      redirect_to google_path
    else
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render 'new'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    add_breadcrumb @user.name, user_path(@user)
    add_breadcrumb I18n.t(:edit), edit_user_path(@user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def all_users
      @users = User.all
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def set_breadcrumb
      add_breadcrumb I18n.t(:home), :root_path
      add_breadcrumb I18n.t(:users), :users_path
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
