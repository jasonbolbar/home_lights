class Switch < ActiveRecord::Base

  attr_accessor :switch_type

  SWITCH_TYPES = %w(Switch Button)

  include GPIO::Api

  validates :pin_number, uniqueness: true, inclusion: GPIO::Api::VALID_PINS, presence: true
  validates :name, presence: true
  validates :time, numericality: {greater_than_or_equal_to: 0.1 ,allow_blank: true, less_than_or_equal_to: 1.0}

  before_validation :define_time

  def turn_on
    pin_high
    update_column(:status, true) if persisted?
  end

  def turn_off
    pin_low
    update_column(:status, false) if persisted?
  end

  def is_a_button?
    time.present?
  end

  def press_button
    raise 'Not a valid button' unless time.present?
    pin_high(time)
  end

  def self.available_switches(pin)
    VALID_PINS - where('pin_number != ?',pin).pluck(:pin_number)
  end

  private

  def define_time
    case switch_type.downcase.to_sym
      when :button
        self.time = 0.1
      else
        self.time = nil
    end
  end

end
