class NotifyBrowserService
  def self.notify event_type, event_data
    if File.exist? "/tmp/websockets_unix.sock"
      client = UNIXSocket.open("/tmp/websockets_unix.sock")

      message = {
        type: "event",
        event: event_data
      }

      message[:event][:type] = event_type

      client.print JSON.generate(message)
      client.close
    end
  end
end