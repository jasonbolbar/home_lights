class Switch < ActiveRecord::Base

  attr_accessor :switch_type

  SWITCH_TYPES = %w(Switch Button)

  include GPIO::Api

  validates :pin_number, uniqueness: true, inclusion: GPIO::Api::VALID_PINS, presence: true
  validates :name, presence: true
  validates :time, numericality: {only_integer: true, greater_than: 100, allow_blank: true}

  before_save :define_time

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

  def self.available_switches
    VALID_PINS - pluck(:pin_number)
  end

  private

  def define_time
    case switch_type.downcase.to_sym
      when :button
        self.time = 100
      else
        self.time = nil
    end
  end

end
