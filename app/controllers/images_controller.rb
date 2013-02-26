class ImagesController < ApplicationController
require 'net/ftp'
  # GET /images
  # GET /images.json
  def index
   if current_user
       if (current_user.username == 'Administrator')
    @websites = Website.all
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
   if current_user
       if (current_user.username == 'Administrator')
    @websites = Website.all
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
   if current_user
       if (current_user.username == 'Administrator')
    @websites = Website.all
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
			else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /images/1/edit
  def edit
   if current_user
       if (current_user.username == 'Administrator')
    @websites = Website.all
    @image = Image.find(params[:id])
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # POST /images
  # POST /images.json
  def create
   if current_user
       if (current_user.username == 'Administrator')
    		file = params[:file]
		@images = Image.find_all_by_nazwa(file.original_filename)

		if @images == nil
    		  ftp = Net::FTP.new('s4.masternet.pl')
        	  ftp.passive = true
    		  ftp.login(user = ENV['ftp_login'], passwd = ENV['ftp_haslo'])
    		  ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    		  ftp.quit()

        	  @image = Image.new
		  @image.nazwa = file.original_filename
        	  @image.opis = params[:opis]

    		  respond_to do |format|
      		    if @image.save
        		format.html { redirect_to websites_path, notice: 'Gratulacje! Dodano zdjecie do galeri' }
        		format.json { render json: @image, status: :created, location: @image }
      		    else
        		format.html { redirect_to websites_path, notice: 'Uwaga! Niepowodznie dodania zdjecia' }
        		format.json { render json: @image.errors, status: :unprocessable_entity }
      		    end
    		  end
		else
		  redirect_to "/images/new", :notice => 'Uwaga! Zdj&#281;cie o takiej nazwie ju&#380; jest w bazie!'
		end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
   if current_user
       if (current_user.username == 'Administrator')
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to websites_path, notice: 'Zdjecie uaktualnione' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
   if current_user
       if (current_user.username == 'Administrator')
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end
end
