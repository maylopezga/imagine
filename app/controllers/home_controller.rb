class HomeController < ApplicationController
  def create
    word = "%#{params[:keyword]}%"
    @pho = Photo.where("title LIKE ? OR body LIKE ?",word,word)

    if user_signed_in?
      @pho.each do |p|
        puts p
        n = p.status
        puts n
        puts "va para el primer if"
        if  p.user_id == current_user.id
          @photos = p
          puts "entro"
        end
        if n == "compartido"
          @photos = p
        end
        if  n == "publico"
          @photos = p
          puts "entro2"
        end
      end
    else
      @pho.each do |p|
        n = p.status
        if n == "publico"
          @photos = p
          puts "entro al segundo "
          puts @photos
        end
      end
    end

    puts "Paso if"
    #@photos = Photo.where("title LIKE ? OR body LIKE ? AND status = ?",word,word,0)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
