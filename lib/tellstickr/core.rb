require 'ffi'

module TellStickR

  class Core

    # FFI wrapper for the telldus-core C library.
    # Versions vary of telldus-core API vary, so far version 2.1.0 is supported.
    # Functions for version 2.1.2 are implemented, but commented out for now.

    extend FFI::Library
    ffi_lib "telldus-core"

    # Device method flags
    TELLSTICK_TURNON = 1
    TELLSTICK_TURNOFF = 2
    TELLSTICK_BELL = 4
    TELLSTICK_TOGGLE = 8
    TELLSTICK_DIM = 16
    TELLSTICK_LEARN = 32
    TELLSTICK_EXECUTE = 64
    TELLSTICK_UP = 128
    TELLSTICK_DOWN = 256
    TELLSTICK_STOP = 512

    # Device types
    TELLSTICK_TYPE_DEVICE = 1
    TELLSTICK_TYPE_GROUP = 2
    TELLSTICK_TYPE_SCENE = 3  

    # Sensor value types
    TELLSTICK_TEMPERATURE = 1
    TELLSTICK_HUMIDITY = 2

    #Controller type
    TELLSTICK_CONTROLLER_TELLSTICK = 1
    TELLSTICK_CONTROLLER_TELLSTICK_DUO = 2
    TELLSTICK_CONTROLLER_TELLSTICK_NET = 3

    # Device changes
    TELLSTICK_DEVICE_ADDED = 1
    TELLSTICK_DEVICE_CHANGED = 2
    TELLSTICK_DEVICE_REMOVED = 3
    TELLSTICK_DEVICE_STATE_CHANGED = 4

    # Change types
    TELLSTICK_CHANGE_NAME = 1
    TELLSTICK_CHANGE_PROTOCOL = 2
    TELLSTICK_CHANGE_MODEL = 3
    TELLSTICK_CHANGE_METHOD = 4
    TELLSTICK_CHANGE_AVAILABLE = 5
    TELLSTICK_CHANGE_FIRMWARE = 6

    # Error codes
    TELLSTICK_SUCCESS = 0
    TELLSTICK_ERROR_NOT_FOUND = -1
    TELLSTICK_ERROR_PERMISSION_DENIED = -2
    TELLSTICK_ERROR_DEVICE_NOT_FOUND = -3
    TELLSTICK_ERROR_METHOD_NOT_SUPPORTED = -4
    TELLSTICK_ERROR_COMMUNICATION = -5
    TELLSTICK_ERROR_CONNECTING_SERVICE = -6
    TELLSTICK_ERROR_UNKNOWN_RESPONSE = -7
    TELLSTICK_ERROR_SYNTAX = -8
    TELLSTICK_ERROR_BROKEN_PIPE = -9
    TELLSTICK_ERROR_COMMUNICATING_SERVICE = -10
    TELLSTICK_ERROR_UNKNOWN = -99

    # Callbacks
    callback :TDDeviceEvent, [:int, :int, :string, :int, :pointer], :void
    callback :TDDeviceChangeEvent, [:int, :int, :int, :int], :void
    callback :TDRawDeviceEvent, [:string, :int, :int], :void
    callback :TDSensorEvent, [:string, :string, :int, :int, :string, :int, :int, :pointer], :void
    callback :TDControllerEvent, [:int, :int, :int, :string, :int], :void

    # Functions
    attach_function :tdInit, [], :void  
    attach_function :tdRegisterDeviceEvent, [:TDDeviceEvent, :pointer], :int
    attach_function :tdRegisterRawDeviceEvent, [:TDRawDeviceEvent, :pointer], :int
    attach_function :tdRegisterDeviceChangeEvent, [:TDDeviceChangeEvent, :pointer], :int
    attach_function :tdRegisterSensorEvent, [:TDSensorEvent, :pointer], :int
    # attach_function :tdRegisterControllerEvent, [:TDControllerEvent, :pointer], :int # Version 2.1.2
    attach_function :tdUnregisterCallback, [:int], :void
    attach_function :tdClose, [], :void
    attach_function :tdReleaseString, [:string], :void
    attach_function :tdTurnOn, [:int], :int
    attach_function :tdTurnOff, [:int], :int
    attach_function :tdBell, [:int], :int
    attach_function :tdDim, [:int], :int
    attach_function :tdExecute, [:int], :int
    attach_function :tdUp, [:int], :int
    attach_function :tdDown, [:int], :int
    attach_function :tdStop, [:int], :int
    attach_function :tdLearn, [:int], :int
    attach_function :tdLastSentCommand, [:int, :int], :int
    attach_function :tdLastSentValue, [:int], :string
    attach_function :tdGetNumberOfDevices, [], :int
    attach_function :tdGetDeviceId, [:int], :int
    attach_function :tdGetDeviceType, [:int], :int
    attach_function :tdGetName, [:int], :string
    attach_function :tdSetName, [:int, :string], :bool
    attach_function :tdGetProtocol, [:int], :string
    attach_function :tdSetProtocol, [:int, :string], :bool
    attach_function :tdGetModel, [:int], :string
    attach_function :tdSetModel, [:int, :string], :bool
    attach_function :tdSetDeviceParameter, [:int, :string, :string], :bool
    attach_function :tdGetDeviceParameter, [:int, :string, :string], :string
    attach_function :tdAddDevice, [], :int
    attach_function :tdRemoveDevice, [:int], :bool
    attach_function :tdMethods, [:int, :int], :int
    attach_function :tdGetErrorString, [:int], :string
    attach_function :tdSendRawCommand, [:string, :int], :int
    attach_function :tdConnectTellStickController, [:int, :int, :string], :void
    attach_function :tdDisconnectTellStickController, [:int, :int, :string], :void
    attach_function :tdSensor, [:pointer, :int, :pointer, :int, :pointer, :pointer], :int
    attach_function :tdSensorValue, [:string, :string, :int, :int, :pointer, :int, :pointer], :int
    # attach_function :tdController, [:pointer, :pointer, :pointer, :int, :pointer], :int # Version 2.1.2
    # attach_function :tdControllerValue, [:int, :pointer, :pointer, :int], :int # Version 2.1.2
    # attach_function :tdSetControllerValue, [:int, :string, :string], :int # Version 2.1.2
    # attach_function :tdRemoveController, [:int], :int # Version 2.1.2
  end
end
