class MedicationsController < ApplicationController

  def index
    @medications = Medication.all
  end
  
  def show
    @medication = Medication.find params[:id]
    @patients = @medication.patients
  end

  def new
    @patients = Patient.all
    @medication = Medication.new
  end

  def create
    @medication = Medication.create medication_params
    redirect_to root_path
  end

  def edit
    @medication = Medication.find params[:id]
    @patients = Patient.all

  end

  def update
    @medication = Medication.find params[:id]
    @medication.update medication_params
    redirect_to root_path
  end

  def destroy
    @medication = Medication.find params[:id]
    @medication.delete
    redirect_to root_path
  end


private
  def medication_params
    params.require(:medication).permit(
        :name,
        :side_effects,
        patient_ids: []
      ) 
  end

  def set_patient
    @patient = Patient.find params[:id]
  end


end
