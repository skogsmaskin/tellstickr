module TellStickR

  class Sensor

    attr_reader :protocol, :model, :id

    def initialize(protocol, model, id)
      @protocol = protocol
      @model = model
      @id = id
      TellStickR::Core.tdInit
    end

    def temperature
      value  = FFI::MemoryPointer.new(:string, 4)
      time  = FFI::MemoryPointer.new(:int, 2)
      TellStickR::Core.tdSensorValue(@protocol, @model, @id, TellStickR::Core::TELLSTICK_TEMPERATURE, value, 4, time)
      {value: value.get_string(0,4).to_f, time: Time.at(time.get_int32(0))}
    end

    def humidity
      value = FFI::MemoryPointer.new(:string, 4)
      time = FFI::MemoryPointer.new(:int, 2)
      TellStickR::Core.tdSensorValue(@protocol, @model, @id, TellStickR::Core::TELLSTICK_HUMIDITY, value, 4, time)
      {value: value.get_string(0,4).to_f, time: Time.at(time.get_int32(0))}
    end

    def self.discover
      TellStickR::Core.tdInit
      sensors = []
      result = TellStickR::Core::TELLSTICK_SUCCESS
      while(true) do
        protocol = FFI::MemoryPointer.new(:string, 32)
        model  = FFI::MemoryPointer.new(:string, 32)
        data_types  = FFI::MemoryPointer.new(:int, 2)
        id = FFI::MemoryPointer.new(:int, 2)
        if TellStickR::Core.tdSensor(protocol, 32, model, 32, id, data_types) == TellStickR::Core::TELLSTICK_SUCCESS
          sensors << Sensor.new(protocol.get_string(0, 32), model.get_string(0, 32), id.get_int32(0))
        else
          break
        end
      end
      sensors
    end

    # A mapping of known protocols and models
    # for different sensor products.
    PREDEFINED_SENSORS = {
      # Clas Ohlson Esic 36-179* sensors
      wt450h: {
        protocol: "mandolyn",
        model: "temperaturehumidity"
      }
    }

    def self.from_predefined(key, id)
      predefined = PREDEFINED_SENSORS[key.to_sym]
      if predefined
        return Sensor.new(predefined[:protocol], predefined[:model], id)
      else
        raise "Unknown sensor product. Predefined sensors: #{PREDEFINED_SENSORS.map{|k,v| k}.join(', ')}"
      end
    end

  end

end
