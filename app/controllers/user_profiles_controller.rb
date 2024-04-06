class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile, only: [:show, :edit, :update]

  def edit
  end

  def show
  end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to user_profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_user_profile
      @user_profile = current_user.user_profile || current_user.build_user_profile
    end

    def user_profile_params
      params.require(:user_profile).permit(:nickname, :bio, :favorite_game)
    end
end
