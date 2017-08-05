class HomeController < ApplicationController
 #Trae la keyword y la busca en Photo, después comprueba si se encuentra algun
 #usuario con la sesión iniciada de ser así, solo busca las publicaciones
 #compartidas, publicas y privadas si este usuario cuenta con dichas
 #publicaciones. Si no han iniciado sesión solo se buscan las publicaciones
 #publicas, luego lo que hace es responder buscando el archivo con la
 #extensión js.
  def create
    word = "%#{params[:keyword]}%"
    @pho = Photo.where("title LIKE ? OR body LIKE ?",word,word)

    if user_signed_in?

      @pho.each do |p|
        puts p
        n = p.status
        if  p.user_id == current_user.id || n == "compartido" || n== "publico"
          @photos = p
        end

      end
    else
      @pho.each do |p|
        n = p.status
        if n == "publico"
          @photos = p
        end
      end
    end
    #@photos = Photo.where("title LIKE ? OR body LIKE ? AND status = ?",word,word,0)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
