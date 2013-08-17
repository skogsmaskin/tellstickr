require 'spec_helper'
require 'tellstickr/core'
describe TellStickR::Core do
  it 'has defined FFI-functions matching tellstick-core v. 2.1.0' do
    functions = [
      :tdInit, 
      :tdRegisterDeviceEvent,
      :tdRegisterRawDeviceEvent,
      :tdRegisterDeviceChangeEvent,
      :tdRegisterSensorEvent,
      :tdUnregisterCallback,
      :tdClose,
      :tdReleaseString,
      :tdTurnOn,
      :tdTurnOff,
      :tdBell,
      :tdDim,
      :tdExecute,
      :tdUp,
      :tdDown,
      :tdStop,
      :tdLearn,
      :tdLastSentCommand,
      :tdLastSentValue,
      :tdGetNumberOfDevices,
      :tdGetDeviceId,
      :tdGetDeviceType,
      :tdGetName,
      :tdSetName,
      :tdGetProtocol,
      :tdSetProtocol,
      :tdGetModel,
      :tdSetModel,
      :tdSetDeviceParameter,
      :tdGetDeviceParameter,
      :tdAddDevice,
      :tdRemoveDevice,
      :tdMethods,
      :tdGetErrorString,
      :tdSendRawCommand,
      :tdConnectTellStickController,
      :tdDisconnectTellStickController,
      :tdSensor,
      :tdSensorValue
    ]
    functions.select{|f| TellStickR::Core.methods.include?(f)}.size.should eq functions.size
  end
end
