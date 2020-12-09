defmodule RequestTimePlug do
  import Plug.Conn

  def init(default), do: default

  def call(%Plug.Conn{} = conn, opts) do
    delay_time = Keyword.get(opts, :response_time, 0)

    conn
    |> assign(:start_time, :os.system_time(:millisecond))
    |> Plug.Conn.register_before_send(fn conn ->
      execution_time = :os.system_time(:millisecond) - conn.assigns[:start_time]
      delay_time = delay_time - execution_time

      if delay_time > 0 do
        Process.sleep(delay_time)
      end

      conn
    end)
  end
end
