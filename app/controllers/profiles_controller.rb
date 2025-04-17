class ProfilesController < ApplicationController

  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def edit
    redirect_to root_path, alert: "Could not edit someone profile" unless @profile.user == current_user
  end

  def update
    if @profile.user == current_user && @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Profile updated"
    else
      flash.now[:alert] = "Could not save changes"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:username, :bio, :avatar)
  end
end

