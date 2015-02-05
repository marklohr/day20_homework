class Patient < ActiveRecord::Base

belongs_to :doctor
has_many :patient_medications
has_many :medications, through: :patient_medications
has_many :nurses, as: :nurseable


    BLOOD_TYPE_OPTIONS = [
    ["O-", "O-"],
    ["O+", "O+"],
    ["A-", "A-"],
    ["A+", "A+"],
    ["B-", "B-"],
    ["B+", "B+"],
    ["AB-", "AB-"],
    ["AB+", "AB+"],
  ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :description, presence: true
  validates :gender, presence: true
  validates :blood_type, presence: true

include Workflow
  workflow do
    state :waiting_room do
      event :checkup, transitions_to: :checkup_room
      event :xray, transitions_to: :xray_room
      event :operate, transitions_to: :surgery_room
      event :pay, transitions_to: :paybill_room
      event :leave, transitions_to: :left
    end

    state :checkup_room do
      event :xray, transitions_to: :xray_room
      event :operate, transitions_to: :surgery_room
      event :pay, transitions_to: :paybill_room
    end

    state :xray_room do
      event :operate, transitions_to: :surgery_room
      event :pay, transitions_to: :paybill_room
    end

    state :surgery_room do
      event :pay, transitions_to: :paybill_room
    end

    state :paybill_room do
      event :leave, transitions_to: :left
    end

    state :left do
      event :wait, transitions_to: :waiting_room
    end
  end
end

