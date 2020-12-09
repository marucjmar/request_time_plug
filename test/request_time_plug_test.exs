defmodule RequestTimePlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @request_time 100
  @offset_execution_request 5

  defmodule Router do
    use Plug.Router
    @request_time 100

    plug(RequestTimePlug, response_time: @request_time)
    plug(:match)
    plug(:dispatch)

    get "/execute/:delay_time" do
      send(self(), :execution_start)
      {time, _} = Integer.parse(conn.params["delay_time"])
      Process.sleep(time)

      send_resp(conn, 200, "world")
    end
  end

  @opts RequestTimePlugTest.Router.init([])

  test "returns value and delay response to param time" do
    delay_time = @request_time - 30
    conn = conn(:get, "/execute/#{delay_time}")

    start_time = :os.system_time(:millisecond)
    conn = RequestTimePlugTest.Router.call(conn, @opts)
    end_time = :os.system_time(:millisecond)
    excution_time = end_time - start_time

    assert_receive :execution_start
    assert excution_time >= @request_time
    assert excution_time <= @request_time + @offset_execution_request
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "returns value without delay when execution time exceeded" do
    delay_time = @request_time + 10
    conn = conn(:get, "/execute/#{delay_time}")

    start_time = :os.system_time(:millisecond)
    conn = RequestTimePlugTest.Router.call(conn, @opts)
    end_time = :os.system_time(:millisecond)
    excution_time = end_time - start_time

    assert_receive :execution_start
    assert excution_time > @request_time
    assert excution_time <= @request_time + delay_time + @offset_execution_request
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
