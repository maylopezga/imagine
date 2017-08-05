class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]

  def index
    @photos = Photo.all
    if user_signed_in?

        @po = Photo.where('status = ? OR status = ?', 2,0)
        #@po1 = Photo.where('status = ?', 2)
        @photos = @po #+ @po1
         puts @photos
    else
      @po1 = Photo.where('status = ?', 0)
      @photos = @po1
      puts "Publico"
    end
    # @photos = Photo.all
    # @statuses = Photo.statuses
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
