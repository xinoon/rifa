class UsersController < ApplicationController
  before_action :inicializar_db
  before_action :authenticate_admin!, except: [:index, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :cancelar, :confirmar]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    unless @user.vacio? || admin_signed_in?
      redirect_to root_path
    end


  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.vacio?
          @user.reservar!
        end
        format.html { redirect_to root_path, notice: 'Reserva realizada con éxito.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirmar
    @user.confirmar!
    redirect_to root_path
  end

  def cancelar
    @user.cancelar!
    @user.name = nil
    @user.email = nil
    @user.save
    redirect_to root_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #Ver si al inicializar_db me permite inicializar number
      params.require(:user).permit(:name, :email, :telefono)
    end

    def inicializar_db
      unless(User.exists?)
        (1..200).each do |i|
          User.create(number: i)
        end
      end
    end
end
