class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all
      # if !params[:search].blank?
      #      @posts = Post.where("name LIKE ?", "%#{params[:search]}%")
      #    else
      #      @posts = @user.posts
      #    end
  end

  def show
    set_doctor
    @patients = @doctor.patients
    @nurse = Nurse.new
    @nurses = @doctor.nurses
    # @nurses = @patient.nurses
  end

  def new
    @doctor = Doctor.new
  end

  def create_nurse
    @doctor = Doctor.find params[:id]
    @nurse = @doctor.nurses.create nurse_params
    redirect_to doctor_path(@doctor)
  end

  def destroy_nurse
    @nurse = Nurse.find params[:id]
    @nurse.destroy
    redirect_to@nurse.nurseable
  end

  def create
    @doctor = Doctor.create doctor_params
    if @doctor.save
      flash[:notice] = 'Physician data was saved successfully.'
      redirect_to doctors_path
    else
      flash[:error] = 'Physician data was NOT saved successfully.'
      render :new
    end
  end

  def edit
    @doctor = Doctor.find params[:id]
  end

  def update
    @doctor = Doctor.find params[:id]
    @doctor.update_attributes doctor_params
    redirect_to doctors_path
  end

  def destroy
    @doctor = Doctor.find params[:id]
    @doctor.delete
    redirect_to doctors_path
  end

  
  private

    def set_doctor
    @doctor = Doctor.find params[:id]
  end

    def doctor_params
      params.require(:doctor).permit(
        :first_name,
        :last_name,
        :biography,
        :gender_name,
        :specialty,
      ) 
  end

  def nurse_params
    params.require(:nurse).permit(
        :name
      )
  end

end
