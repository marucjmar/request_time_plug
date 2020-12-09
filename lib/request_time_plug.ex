defmodule RequestTimePlug do
  import Plug.Conn

  def init(default), do: default

  @spec call(Plug.Conn.t(), keyword) :: Plug.Conn.t()
  def call(%Plug.Conn{} = conn, opts) do
    resp_time = Keyword.get(opts, :response_time, 0)

    conn
    |> assign(:start_time, now())
    |> Plug.Conn.register_before_send(&before_send(&1, resp_time))
  end

  @spec before_send(Plug.Conn.t(), integer()) :: Plug.Conn.t()
  defp before_send(%{assigns: %{start_time: start_time}} = conn, resp_time)
       when is_integer(start_time) do
    execution_time = now() - start_time
    delay_time = resp_time - execution_time

    if delay_time > 0 do
      Process.sleep(delay_time)
    end

    conn
  end

  defp before_send(conn, _), do: conn

  @spec now() :: integer()
  defp now(), do: :os.system_time(:millisecond)
end
