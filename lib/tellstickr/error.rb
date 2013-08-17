module TellStickR

    class Error < StandardError

      def initialize(code)
        @code = code
        super(human_message)
      end

      def human_message
        case @code
          when TellStickR::Core::TELLSTICK_ERROR_NOT_FOUND
            "Tellstick not found (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_PERMISSION_DENIED
            "Permission denied accessing the Tellstick (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_DEVICE_NOT_FOUND
            "The supplied device id was not found (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_METHOD_NOT_SUPPORTED
            "The requested method is not supported by the device (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_COMMUNICATION
            "An error occurred when communicating with the TellStick (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_CONNECTING_SERVICE
            "The client library could not connect to the service. Maybe it is not running? (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_UNKNOWN_RESPONSE
            "The client library received a response from the service it did not understand (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_SYNTAX
            "Input/command could not be parsed or didn't follow input rules (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_BROKEN_PIPE
            "Pipe broken during communication (#{@code})"
          when TellStickR::Core::TELLSTICK_ERROR_COMMUNICATING_SERVICE
            "Timeout waiting for response from the Telldus Service (#{@code})"
          else TellStickR::Core::TELLSTICK_ERROR_UNKNOWN
            "An unknown error has occurred (#{@code})"
        end
      end

    end
end
