class PatientsController < ApplicationController
  before_action :set_patient, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :wait_patient
  ]

  def index
    @patients = Patient.all
  end
  
  def show
    set_patient
    @doctor = Doctor.find params[:doctor_id]
    @patient = Patient.find params[:id]
    @medications = @patient.medications
    @nurse = Nurse.new
    @nurses = @patient.nurses
  end

  def new
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.new
    @medications = Medication.all

  end

  def create
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.create patient_params
    @medications = Medication.all
    redirect_to doctor_path(@doctor)
  end

  def edit
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:id]
    @medications = Medication.all

  end

  def update
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:id]
    @patient.update patient_params
    redirect_to doctor_path(@doctor)
  end

  def destroy
    @patient = Patient.find params[:id]
    @doctor = Doctor.find params[:doctor_id]
    if @patient.delete
      flash[:notice] = 'Patient data was deleted successfully.'
      redirect_to doctor_path(@doctor)
    else
      flash[:notice] = 'Patient data was NOT deleted successfully.'
    end
  end

def create_nurse
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:id] 
    @nurse = @patient.nurses.create nurse_params
    redirect_to doctor_patient_path(@doctor, @patient)
  end

  def destroy_nurse
    @nurse = Nurse.find params[:nurse_id]
    @nurse.destroy
    redirect_to root_path
  end

def wait_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.wait!
  redirect_to doctor_patient_path
end

def checkup_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.checkup!
  redirect_to doctor_patient_path
end

def xray_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.xray!
  redirect_to doctor_patient_path
end

def operate_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.operate!
  redirect_to doctor_patient_path
end

def pay_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.pay!
  redirect_to doctor_patient_path
end

def leave_patient
  @doctor = Doctor.find params[:doctor_id]
  @patient = @doctor.patients.find params[:id]
  @patient.leave!
  redirect_to doctor_patient_path
end

private
  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :date_of_birth,
        :description,
        :gender,
        :blood_type,
        medication_ids: []
      ) 
  end

  def set_doctor
    @doctor = Doctor.find params[:id]
  end

  def set_patient
    @patient = Patient.find params[:id]
  end

  def nurse_params
    params.require(:nurse).permit(
        :name
      )
  end
end
