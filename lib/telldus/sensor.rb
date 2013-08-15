module Telldus

  class Sensor

    PREDEFINED_SENSORS = {
      wt450h: {
        protocol: "mandolyn",
        model: "temperaturehumidity"
      }
    }

    def self.from_label_and_id(label, id)
      device = PREDEFINED_SENSORS[label.to_sym]
      if device
        return Sensor.new(device[:protocol], device[:model], id)
      else
        raise "Unknown device. Defined devices: #{PREDEFINED_SENSORS.map{|k,v| k}.join(', ')}"
      end
    end

    def self.discover
      sensors = []
      result = Telldus::Core::TELLSTICK_SUCCESS
      Telldus::Core.tdInit
      while(result == Telldus::Core::TELLSTICK_SUCCESS) do
        protocol = FFI::MemoryPointer.new(:string, 32)
        model  = FFI::MemoryPointer.new(:string, 32)
        data_types  = FFI::MemoryPointer.new(:int, 2)
        id = FFI::MemoryPointer.new(:int, 2)
        result = Telldus::Core.tdSensor(protocol, 32, model_p, 32, id, data_types)
        if result == Telldus::Core::TELLSTICK_SUCCESS
          sensors << Sensor.new(protocol.get_string(0,32), model.get_string(0,32), id.get_int32(0))
        end
      end
      sensors
    end

    def initialize(protocol, model, id)
      @protocol = protocol
      @model = model
      @id = id
    end

    def temperature
      value  = FFI::MemoryPointer.new(:string, 4)
      time  = FFI::MemoryPointer.new(:int, 2)
      Telldus::Core.tdSensorValue(@protocol, @model, @id, Telldus::Core::TELLSTICK_TEMPERATURE, value, 4, time)
      {value: value.get_string(0,4).to_f, time: Time.at(time.get_int32(0))}
    end

    def humidity
      value  = FFI::MemoryPointer.new(:string, 3)
      time  = FFI::MemoryPointer.new(:int, 2)
      Telldus::Core.tdSensorValue(@protocol, @model, @id, Telldus::Core::TELLSTICK_HUMIDITY, value, 3, time)
      {value: value.get_string(0,3).to_f, time: Time.at(time.get_int32(0))}
    end
  end

end
