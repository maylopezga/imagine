class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  def index
    @photos = Photo.all
  end
  def show
    @photo = Photo.find(params[:id])
    @photo.update_visits_count
  end
  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
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
    if @photo.update(photo_params)
      redirect_to @photo
    else
      render :edit
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title,:body)

  end
end
