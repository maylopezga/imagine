class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]

  def index
    @photos = Photo.all
    if user_signed_in?
      # @photos.each do |p|
      #   if current_user.id == p.user_id
      #     @photo = p
      #   end
      #   n = p.status
      #   if n == "publico" || n == "compartido"
      #     @photo = p
      #     puts "enttro a atupoeh"
      #   end
      # end
      # @photos = @photo
      #
      @po = Photo.where('status = ? OR status = ? OR user_id = ?', 2,0, current_user.id)
      @photos = @po

    else
      @po1 = Photo.where('status = ?', 0)
      @photos = @po1
    end

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
    if current_user.id == @photo.user_id
      puts "Puede editar"
    else
      redirect_to @photo
    end
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
    if current_user.id == @photo.user_id
      @photo.destroy
      redirect_to photos_path
    end

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
    params.require(:photo).permit(:title,:body,:status, :cover)

  end
end
