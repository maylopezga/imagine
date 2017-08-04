class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  def index
    @photos = Photo.all
    @statuses = Photo.statuses
  end
  def show
    @photo = Photo.find(params[:id])
    @photo.update_visits_count
  end

  def new
    @photo = Photo.new
    @statuses = Photo.statuses
  end

  def edit
    @photo = Photo.find(params[:id])
    @statuses = Photo.statuses
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      redirect_to @photo
    else
      render :new
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end

  def update
    @photo = Photo.find(params[:id])
    @statuses = Photo.statuses
    if @photo.update(photo_params)
      redirect_to @photo
    else
      render :edit
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title,:body,:status)

  end
end
