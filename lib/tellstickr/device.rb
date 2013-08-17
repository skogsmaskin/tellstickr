module TellStickR

  class Device

    attr_reader :id, :name, :protocol, :model

    def initialize(id, name, protocol, model)
      @id = id
      @name = name
      @protocol = protocol
      @model = model
    end

    def learn
      result = TellStickR::Core.tdLearn(@id)
      return true if result == TellStickR::Core::TELLSTICK_SUCCESS
      raise TellStickR::Error.new(result)
    end

    def on
      result = TellStickR::Core.tdTurnOn(@id)
      return true if result == TellStickR::Core::TELLSTICK_SUCCESS
      raise TellStickR::Error.new(result)
    end

    def off
      result = TellStickR::Core.tdTurnOff(@id)
      return true if result == TellStickR::Core::TELLSTICK_SUCCESS
      raise TellStickR::Error.new(result)
    end

    def bell
      result = TellStickR::Core.tdBell(@id)
      return true if result == TellStickR::Core::TELLSTICK_SUCCESS
      raise TellStickR::Error.new(result)
    end

    def self.discover
      nr_of_devices = TellStickR::Core.tdGetNumberOfDevices
      i = 0
      devices = []
      while(i < nr_of_devices) do
        id = TellStickR::Core.tdGetDeviceId(i)
        name = TellStickR::Core.tdGetName(i)
        protocol = TellStickR::Core.tdGetProtocol(i)
        model = TellStickR::Core.tdGetModel(i)
        devices << Device.new(id, name, protocol, model)
        i += 1
      end
      devices
    end

  end

end
