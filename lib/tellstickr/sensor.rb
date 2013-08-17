module TellStickR

  class Sensor

    attr_reader :protocol, :model, :id

    def initialize(protocol, model, id)
      @protocol = protocol
      @model = model
      @id = id
      @callback_functions = {}
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

    def register_callback(proc)
      object_id  = FFI::MemoryPointer.new(:int32)
      object_id.write_int32(self.object_id)
      callback = Proc.new do |protocol, model, id, data_type, value, timestamp, callback_id, context|
        sensor = ObjectSpace._id2ref(context.get_int32(0))
        if id == sensor.id
          sensor.callback_functions[callback_id].call({
            kind: (data_type == TellStickR::Core::TELLSTICK_TEMPERATURE ? :temperature : :humidity),
            value: value.to_f, time: Time.at(timestamp.to_i)
          })
        end
      end
      id = TellStickR::Core.tdRegisterSensorEvent(callback, object_id)
      @callback_functions[id] = proc
      id
    end

    def unregister_callback(id)
      TellStickR::Core.tdUnregisterCallback(id)
      @callback_functions.delete(id)
    end

    def unregister_callbacks
      @callback_functions.each do |k,v|
        TellStickR::Core.tdUnregisterCallback(k)
        @callback_functions.delete(k)
      end
      @callback_functions
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
