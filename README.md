# README

By: Mayerli López - maye.lopez16@gmail.com ~ mlopez12@eafit.edu.co

DESARROLLO

  Crear application
    mlopez@dev$ rails new imagine

  Generar controlador de 'photos'
    mlopez@dev$ rails generate controller Photos
  Crear el form para entrar datos
      app/views/photos/_form.html.erb:

      <%= form_for @photo do |f|%>
        <% @photo.errors.full_messages.each do |message| %>
          <div>
            <%= message %>
          </div>
        <% end %>
        <div class="field2">
          <%= label_tag( "Imagen de la publicación") %><br />
          <div class="field">
            <%=f.file_field :cover, placeholder: "Imagen", class:"font-button btn let be-black"%>
          </div>
        </div>
        <div class="field">
          <%= label_tag(:title, "Título de la publicación") %><br />
          <%=f.text_field :title, placeholder: "Título", class:"form-control"%>
        </div>
        <div class="field">
          <%= label_tag(:body, "Contenido") %><br />
          <%= f.text_area :body, placeholder: "Contenido de la publicación", style:"height:250px;", class:"form-control"%>
        </div>

        <div class="row">
           <div class="col-xs-12 form-group">
             <%= f.label :status %>
             <%= f.select :status, options_for_select(@statuses.collect { |s| [s[0].humanize, s[0]] }, selected: @photo.status), {} , class: "form-control" %>
           </div>
         </div>

        <div class="actions field center font-button">
          <%= f.submit "Publicar", class: "btn let be-black" %>
        </div>
      <%end%>

    Creando el modelo

    class CreatePhotos < ActiveRecord::Migration[5.1]
      def change
        create_table :photos do |t|
          t.string :title
          t.text :body
          t.integer :visit_count, default: 0

          t.timestamps
        end
      end
    end

    Correr migración
      mlopez@dev$ rails db:migrate

    Routes

                   photos GET    /photos(.:format)              photos#index          No tiene parámetros
                          POST   /photos(.:format)              photos#create
                new_photo GET    /photos/new(.:format)          photos#new            No tiene parámetros
               edit_photo GET    /photos/:id/edit(.:format)     photos#edit           Manda datos como parte de la URL
                    photo GET    /photos/:id(.:format)          photos#show           Manda datos como parte de la URL
                          PATCH  /photos/:id(.:format)          photos#update         Manda datos como parte de la URL
                          PUT    /photos/:id(.:format)          photos#update         Manda datos como parte de la URL
                          DELETE /photos/:id(.:format)          photos#destroy        Manda datos como parte de la URL
         new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
             user_session POST   /users/sign_in(.:format)       devise/sessions#create
     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
            user_password PATCH  /users/password(.:format)      devise/passwords#update
                          PUT    /users/password(.:format)      devise/passwords#update
                          POST   /users/password(.:format)      devise/passwords#create
  cancel_user_registration GET   /users/cancel(.:format)        devise/registrations#cancel
    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
        user_registration PATCH  /users(.:format)               devise/registrations#update
                          PUT    /users(.:format)               devise/registrations#update
                          DELETE /users(.:format)               devise/registrations#destroy
                          POST   /users(.:format)               devise/registrations#create
              home_create GET    /home/create(.:format)         home#create
                     root GET    /                              photos#index



DESPLIEGUE EN UN SERVIDOR CENTOS
  Instalar Ruby y rails

  local$ ssh mlopez@10.131.137.240
  Password: *****

  Instalar rvm
  mlopez@test$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

  mlopez@test$ \curl -sSL https://get.rvm.io | bash

  Instalar Ruby 2.4.0
   mlopez@test$ rvm install 2.4.0
  Instalar rails
   mlopez@test gem install rails
  Instalar base de datos postgresql
   mlopez@test$ sudo yum install -y postgresql-server postgresql-contrib postgresql-devel
   Password: *****

   mlopez@test$ sudo postgresql-setup initdb

   mlopez@test$ sudo vi /var/lib/pgsql/data/pg_hba.conf

      original:

      host    all             all             127.0.0.1/32            ident
      host    all             all             ::1/128                 ident

      updated:

      host    all             all             127.0.0.1/32            md5
      host    all             all             ::1/128                 md5

  Correr postgres:

    mlopez@test$ sudo systemctl start postgresql
    mlopez@test$ sudo systemctl enable postgresql

  Crear DB y usuario:

    mlopez@test$ sudo su - postgres

    mlopez@test$ createuser -s may

    mlopez@test$ psql

    postgres=# \password may
    Enter new password: 123

    postgres=# \q

    mlopez@test$ exit

    mlopez@test$ export RAILS_ENV=test
    mlopez@test$ export PORT=4000

    Abrir el puerto 4000 en firewalld service

    mlopez@test$ sudo firewall-cmd --zone=public --add-port=4000/tcp --permanent
    mlopez@test$ sudo firewall-cmd --reload

    Clonar y correr repositorio

    mlopez@test$ mkdir apps
    mlopez@test$ cd apps
    mlopez@test$ git clone https://github.com/maylopezga/imagine.git
    mlopez@test$ cd imagine
    mlopez@test$ bundle install
    mlopez@test$ rake db:drop db:create db:migrate
    mlopez@test$ export RAILS_ENV=test
    mlopez@test$ export PORT=4000
    mlopez@test$ rails server

    Producción con NGINX

    mlopez@prod$ sudo yum install nginx
    mlopez@prod$ sudo systemctl enable nginx
    mlopez@prod$ sudo systemctl start nginx

    mlopez@prod$ cd rubyArticulosEM
    mlopez@prod$ export RAILS_ENV=test
    mlopez@prod$ export PORT=4000
    mlopez@prod$ rails server
    => Booting Puma
    => Rails 5.1.2 application starting in test on http://0.0.0.0:4000
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.9.1 (ruby 2.4.0-p111), codename: Private Caller
    * Min threads: 5, max threads: 5
    * Environment: test
    * Listening on tcp://0.0.0.0:4000
    Use Ctrl-C to stop



    Configurar /etc/nginx/nginx.conf

    App from browser: http://10.131.137.240/imagine

    // /etc/nginx/nginx.conf

    location /imagine/ {
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header HOST $http_host;
      proxy_set_header X-NginX-Proxy true;
      proxy_pass http://127.0.0.1:4000;
      proxy_redirect off;
    }


    Modificar la ruta de la app

    // modify config/routes.rb
    # ej: http://10.131.137.240/imagine
    Rails.application.routes.draw do
      scope '/imagine' do
        resources :photos
        devise_for :users
        get 'home/create'
        root 'photos#index
      end
    end

DESPLIEGUE EN HEROKU

    mlopez$ heroku login

    mlopez$ cd imagine

    mlopez$ heroku create
    Creating app... done, ⬢ imagineml
    https://imagineml.herokuapp.com/

    mlopez$ git push heroku master
