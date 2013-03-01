class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
   if current_user
       if (current_user.username == 'Administrator')
    @websites = Website.all
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @websites = Website.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
   if current_user
    redirect_to websites_path, :notice => 'Informacja! Wyloguj si&#281; aby dokona&#263; rejestracji'
   else
    redirect_to websites_path, :notice => 'Informacja! Rejestracja zosta&#322;a wy&#322;&#261;czona'
   end
  end

  # GET /users/1/edit
  def edit
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @websites = Website.all
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # POST /users
  # POST /users.json
 def create
   redirect_to websites_path, :notice => 'Informacja! Rejestracja zosta&#322;a wy&#322;&#261;czona'
end

  # PUT /users/1
  # PUT /users/1.json
  def update
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'Informacja! Konto uaktualnione' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    	@user.destroy

    respond_to do |format|
      format.html { redirect_to websites_path, :notice => 'Informacja! U&#380;ytkownik usuni&#281;ty' }
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
