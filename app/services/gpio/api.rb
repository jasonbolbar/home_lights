module GPIO
  module Api

    VALID_PINS = [17, 27, 22, 5, 6, 13, 26, 23, 24, 25, 12, 16]

    def pin_high(time=nil)
      raise GPIO::PinNotFoundError unless pin_exists?
      execute_command "gpio -g write #{pin_number} 1"
      unless time.nil?
        raise GPIO::InvalidTimeError unless time.is_a?(Float) && time >= 0.1
        sleep time
        pin_low
      end
    end

    def pin_low
      raise GPIO::PinNotFoundError unless pin_exists?
      execute_command "gpio -g write #{pin_number} 0"
    end

    protected

    def pin_exists?
      VALID_PINS.include?(pin_number)
    end

    def execute_command(command)
      Rails.logger.info command
      if Rails.env.production?
        system command
      end
    end

  end

  class PinNotFoundError < StandardError

    def message
      'The pin does not exist on the Raspberry'
    end

  end

  class InvalidTimeError < StandardError

    def message
      'You have provided and invalid time'
    end

  end

end
