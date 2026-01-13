class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      redirect_to root_url, :notice => "Registered"
    else
      render "new"
    end
  end

  private

  def sign_up_params
    params.expect(user: [ :email, :password, :password_confirmation ])
  end
end
