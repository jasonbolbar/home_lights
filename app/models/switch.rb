class Switch < ActiveRecord::Base

  include GPIO::Api

  validates :pin_number, uniqueness: true, inclusion: GPIO::Api::VALID_PINS, presence: true
  validates :name, presence: true
  validates :time, numericality: {only_integer: true, greater_than: 100}

  def turn_on
    pin_high
    update_column(:status,true) if persisted?
  end

  def turn_off
    pin_low
    update_column(:status,false) if persisted?
  end

  def on?
    status
  end

  def off?
    !status
  end

  def press_button
    raise 'Not a valid button' unless time.present?
    pin_high(time)
  end

end
